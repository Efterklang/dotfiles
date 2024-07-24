from github import Notification


def format_string(string, notification: Notification):
    number = ''
    num_symbol = ''
    release_title = ''
    if notification.subject.type == "PullRequest" or notification.subject.type == "Issue":
        number = notification.subject.url.split('/')[-1]
        num_symbol = '#'
    else:
        release_title = f"{notification.subject.title} in "
    return string.format(
        subject_url=notification.subject.url,
        number=number,
        num_symbol=num_symbol,
        repo_full_name=notification.repository.full_name,
        repo_owner=notification.repository.owner.login,
        repo_name=notification.repository.name,
        reason_title=notification.reason.title(),
        subject_title=notification.subject.title,
        release_title=release_title
    )
