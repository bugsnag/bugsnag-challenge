Bugsnag Coding Challenge
========================

Background
----------

Bugsnag automatically detects crashes in people's applications, and sends them
to our servers for display on the Bugsnag dashboard.

As soon as we detect a crash, we use HTTP POST to send a json-encoded error
payload to our servers.

In some situations, especially apps with a high volume of crashes or finely
tuned applications, it is preferable to batch up these error payloads to a log
file, and have another script send them to Bugsnag asynchronously.


Challenge
---------

In the scripting language of your choice, create a *robust* script that posts
all error payloads from our log file to Bugsnag's notify endpoint. We've
provided a script `buggy_app.rb` that writes new crash payloads to a log file
at random intervals.

-   Make sure the `buggy_app.rb` script is running at the same time your
    script runs, so that data is constantly being written to the log file you
    are processing
-   The Bugsnag notify endpoint URL is <https://notify.bugsnag.com>
-   The Content-Type of each payload should be `application/json`
-   Every error should be sent exactly once to our servers


Running buggy_app.rb
--------------------

-   Make sure you have ruby on your system (all macs come with ruby installed)
-   Create an account and a new project on bugsnag.com
-   Copy the api key for your new bugsnag project
-   Run the buggy_app script: ruby buggy_app.rb api-key-here
-   The script will generate a file, `bugsnag.log`, containing error payloads


Testing Your Script
-------------------

If your script is posting error payloads to bugsnag correctly, you'll see:

-   A 200 response from notify.bugsnag.com
-   Errors should appear on your Bugsnag dashboard


Extensions
----------

If you finish quickly, here are some ideas for extension projects to improve
the script:

-   What changes would you make to the error payload to more efficiently batch
    up the sending of errors to our servers? Modify `buggy_app.rb` to change 
    the payload format if required.

    See our Notifier API (https://bugsnag.com/docs/notifier-api) docs
    for more information.

-   Consider how to recover if your script crashes.