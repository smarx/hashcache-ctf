# HashCache-CTF

## Welcome to the HashCache capture the flag challenge!

In the context of computer security, a [Capture the Flag (CTF) competition](https://en.wikipedia.org/wiki/Capture_the_flag#Computer_security) is a game about finding and exploiting software vulnerabilities.

You _may_ be able to find this code running at http://hashcache-ctf.smarx.com/. I deployed it in August of 2020, so if you're reading this much later than that, it's probably long gone.

Note that you _will_ need to read the source code for the app to solve this challenge.

## What am I supposed to do?

You're supposed to capture the flag! Specifically, there's a `flag` key stored in Redis, and you're supposed to read its value.

You **don't** need to spam my server with a bunch of requests. If you find yourself doing that, you're on the wrong track. I recommend that you _run the code locally_ (see below) and figure out how to hack it there. Once you've figured that out, you can use the same process to get the real flag from the real server.

## What do I do if I win?

Once people have had an opportunity to solve the challenge, I'm going to write a blog post about it. I'd love to list you there as a winner!

Just send an email to [smarx@smarx.com](mailto:smarx@smarx.com) with **the flag** (which looks like `flag{...}`), **your name (or nickname/handle)**, and **a URL you want me to link to**. (I reserve the right to censor names and URLs I don't like.)

## How do I run the code locally?

There are a few ways. The easiest way, if you're into Docker, is to run `docker-compose up -d --build`. This will get things running at http://127.0.0.1:8080. Use `docker-compose down` to turn it off again.

If you're not set up for Docker, you can instead install [redis](https://redis.io/) and [nim](https://nim-lang.org/) locally. Make sure `redis-server` is running, and then use `nimble run -d:ssl`.

Note that the local version of the code will give you a fake flag. You need to hack the production service (http://hashcache-ctf.smarx.com) to get the real flag.

## What if something's broken or I need help?

Please email me! [smarx@smarx.com](mailto:smarx@smarx.com)

If something's broken, I'll try to fix it.

If you're struggling with the CTF and don't know what to do, tell me what you've tried so far, and I'll give you a hint to nudge you in the right direction.
