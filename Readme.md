## McChunkie Jr

This is a chatbot for the popular (at least I think it's popular) GroupMe group
messaging application. This bot is heavily inspired and based on
[Aaron Bieber](https://github.com/qbit/)'s IRC Bot,
[McChunkie](https://github.com/qbit/mcchunkie/). This bot was written (mostly)
over the course of an afternoon, and as such, may have unexplored bugs.

## Features and Commands

Currently, McChunkie Jr has only a few commands:

* !weather - limited to just one location (because I keep forgetting to fix it)
* !beer `foo` - uses the fantastic [brewerydb](http://brewerydb.com) to look up the
beer `foo`
* o/ (and \o) - because sometimes, high fives just make you feel better
* !sherlock - a moderately bad Markov chain working with Arthur Conan Doyle's
*The Adventures of Sherlock Holmes*.


## Disclaimer:

This code is pretty terrible. Like I said, I wrote it mostly in an afternoon
while trying to waste just a little time. This will probably only be useful for
me, and I don't particularly recommend using it. If you're really motivated,
however, you will need API keys from: [GroupMe](https://dev.groupme.com/bots),
[Wunderground](http://www.wunderground.com/weather/api/), and
[BreweryDB](http://brewerydb.com/developers/).

Also, I don't particularly recommend running `git log` or looking at the history
at all. Honestly, it's so bad that I feel bad looking through it. Now that
McChunkie Jr is on Github, I will probably take a little more care with it. But
maybe not. Who knows?

## Contribooting

If you really feel like making a pull request, feel free to do so under a fork
and new branch.
