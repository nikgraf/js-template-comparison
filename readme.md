# Comparison of Javascript Template Engines

This project contains different implementations of various JavaScript template engines.
I wanted to create a simple example, which covers a lot of use-cases to evaluate how various
template engines work in the browser.

This project only contains examples to see how they are used. For performance tests check out [http://jsperf.com/dom-vs-innerhtml-based-templating/73](http://jsperf.com/dom-vs-innerhtml-based-templating/73)

## Tested Engines

* [eco](https://github.com/sstephenson/eco)
* [jQuery-templ](http://api.jquery.com/category/plugins/templates/)

## Requirements

The template should contain

* if/else condition
* helper for generating gravatar image by email
* loop containing
  * gravatar
  * name
* nested translations

So i came up with this example:

### Wanted output

    <h1>Brunch ~ with coffee</h1>
    <dl>
      <dt>type</dt>
      <dd>open source</dd>
      <dt>since</dt>
      <dd>2011</dd>
    </dl>
    <h2>team</h2>
    <ul>
      <li><img src="http://www.gravatar.com/avatar/7111722195d87231c263add622a583b6.png?s=32"> Nik Graf</li>
      <li><img src="http://www.gravatar.com/avatar/4c73a340266b12611feb5ce5069b6f43.png?s=32"> Tosh</li>
    </ul>

### Provided data

    data =
      organisation:
        name: 'Brunch ~ with coffee'
        type: 'open_source'
        since: 2011
        team: [
          nik =
            name: "Nik Graf"
            email: "nik@deck.cc"
          tosh =
            name: "Tosh"
            email: "tosh@deck.cc" ]

### Provided translations

    organisation:
      since: 'since'
      type: 'type'
      type_list:
        open_source: 'open source'
      team: 'team'

## Develop

Run the runcoffee shell script to compile the files for an engine.

example:

    ./runcoffee.sh eco

Please recompile documents after changing the code via

    ./rundocco.sh    