from flox import Flox, utils
import json
import webbrowser
from github import Github
from github.GithubException import BadCredentialsException, RateLimitExceededException
from phrases import phrases
from random import choice
from pathlib import Path
from .helper import format_string

DEFAULT_MAX_RESULTS = 20
UNREAD_ICON = Path(__file__).parent.joinpath('icons', 'unread2.png').resolve()
READ_ICON = Path(__file__).parent.joinpath('icons', 'read.png').resolve()
UNREAD_ICONS = {
    True: UNREAD_ICON,
    False: READ_ICON
}
TITLE_TEMPLATE = "{repo_owner}/{repo_name} {num_symbol}{number}"
SUBTITLE_TEMPLATE = "[{reason_title}] {subject_title}"


class GithubNotifications(Flox):

    def _init_github(self):
        self.gh = Github(self.settings.get('token', ''))

    @utils.cache('gh.json', max_age=5)
    def main_search(self):
        self._init_github()
        max = int(self.settings.get('max_results', DEFAULT_MAX_RESULTS))
        notifications = self.gh.get_user().get_notifications(all=True)[:max]
        for notification in notifications:
            url = notification.subject.url
            icon = UNREAD_ICONS[notification.unread]
            title_format = self.settings.get('title', TITLE_TEMPLATE)
            subtitle_format = self.settings.get('subtitle', SUBTITLE_TEMPLATE)
            self.add_item(
                title=format_string(title_format, notification),
                subtitle=format_string(subtitle_format, notification),
                icon=icon,
                method=self.open_url,
                parameters=[url, notification.id],
                context=[notification.id]
            )
        return self._results

    def filter_results(self, query):
        results = []
        for result in self._results:
            if query.lower() in result['Title'].lower():
                results.append(result)
        self._results = results

    def query(self, query):
        try:
            self._results = self.main_search()
            self.filter_results(query)
        except BadCredentialsException:
            self.add_item(
                title="Could not login to Github",
                subtitle="Bad or missing Personal Access Token."
            )
        except RateLimitExceededException:
            self.add_item(
                title="Rate limit exceeded",
                subtitle="You have reached the rate limit for this hour."
            )
        if len(self._results) == 0:
            subtitle = choice(phrases)
            self.add_item(
                title="No notifications",
                subtitle=subtitle
            )
        return self._results

    def context_menu(self, data):
        try:
            id = data[0]
        except (IndexError, TypeError):
            return
        else:
            self.add_item(
                title="Mark as read",
                subtitle='Mark notification as read.',
                method=self.mark_read,
                parameters=[id],
            )
            self.add_item(
                title="Mark all as read",
                subtitle='Mark all notifications as read.',
                method=self.clear_all,
            )
        finally:
            self.add_item(
                title="Refresh Cache",
                subtitle='Refresh the cache.',
                method=self.refresh_cache
            )

    def cache_remove_result(self, id):
        if utils.cache_path('gh.json').exists():
            with open(utils.cache_path('gh.json'), 'r') as f:
                cache = json.load(f)
            for result in cache:
                if result['ContextData'][0] == id:
                    cache.remove(result)
                    with open(utils.cache_path('gh.json'), 'w') as f:
                        json.dump(cache, f)

    def mark_read(self, id):
        self.gh_mark_as_read(id)
        self.change_query(self.query, True)

    def refresh_cache(self):
        utils.remove_cache('gh.json')

    def clear_all(self):
        self._init_github()
        notifications = self.gh.get_user().get_notifications()
        for notification in notifications:
            notification.mark_as_read()
            self.cache_remove_result(notification.id)

    def open_url(self, url, id):
        self._init_github()
        self.gh_mark_as_read(id)
        header, data = self.gh.get_user()._requester.requestJsonAndCheck(
            "GET",
            url
        )
        webbrowser.open(data['html_url'])

    def gh_mark_as_read(self, id):
        try:
            self._init_github()
            self.gh.get_user().get_notification(id).mark_as_read()
            self.cache_remove_result(id)
        except BadCredentialsException:
            self.logger.error("Bad or missing Personal Access Token.")
        except RateLimitExceededException:
            self.logger.warning("Rate limit exceeded")


if __name__ == "__main__":
    GithubNotifications()
