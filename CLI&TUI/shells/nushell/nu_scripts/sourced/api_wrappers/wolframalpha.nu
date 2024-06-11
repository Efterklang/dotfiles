let appID = "" #YOUR APP_ID

<<<<<<< HEAD
#Fetch simple anwser from WolframAlpha API
=======
#Fetch simple answer from WolframAlpha API
>>>>>>> 407a313bbb13bd5ce2de16768ab2ebec7c111657
def wolfram [...query #Your query
] {
    let query_string = ($query | str join " ")
    let result = (http get ("https://api.wolframalpha.com/v1/result?" + ([[appid i]; [$appID $query_string]] | url build-query)))
    $result + ""
}

<<<<<<< HEAD
#Fetch image with full anwser from WolframAlpha API
=======
#Fetch image with full answer from WolframAlpha API
>>>>>>> 407a313bbb13bd5ce2de16768ab2ebec7c111657
def wolframimg [...query #Your query
] {
    let query_string = ($query | str join " ")
    let filename = ($query_string + ".png")
    let link = ("https://api.wolframalpha.com/v1/simple?" + ([[appid i]; [$appID $query_string]] | url build-query) + "&background=F5F5F5&fontsize=20")
    http get $link | save $filename
    echo ("Query result saved in file: " + $filename)
}
