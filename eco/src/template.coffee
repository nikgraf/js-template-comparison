# helpers we use in our templates
helpers =
  # provides an easy way to access translations in jquery-global
  translate: (key, language) ->
    localize_path = key.split('.')
    depth = localize_path.length
    localized = jQuery.global.localize(localize_path[0], language)
    for i in [1..depth-1]
      localized = localized[localize_path[i]]
    localized
  # generates a gravatar image by it's given email
  gravatar: (email, size) ->
    hashed_email = md5 email
    src = "http://www.gravatar.com/avatar/#{hashed_email}.png"
    src += "?s=#{size}" if size
    @safe "<img src=\"#{src}\">"

# simulate a dataset which could come from localstorage or fetched via ajax
data =
  organisation:
    name: 'Brunch ~ with coffee'
    type: 'open_source'
    since: 2011
    team: [
      nik =
        name: "Nik Graf"
        email: "nik" + "@" + "deck.cc"
      tosh =
        name: "Tosh"
        email: "tosh" + "@" + "deck.cc" ]

# add template funcions to our given dataset
data.t = helpers.translate
data.gravatar = helpers.gravatar

# set prefered language for jquery-global
$.global.preferCulture "en"

# add translations
$.global.localize("site", "en",
  organisation:
    since: 'since'
    type: 'type'
    typeList:
      open_source: 'open source'
    team: 'team'
)

# eco template string
template = '
  <h1><%= @organisation.name %></h1>

  <dl>
    <dt><%= @t "site.organisation.type" %></dt>
    <dd><%= @t "site.organisation.typeList.#{@organisation.type}" %></dd>
    <dt><%= @t "site.organisation.since" %></dt>
    <dd><%= @organisation.since %></dd>
  </dl>

  <h2><%= @t "site.organisation.team" %></h2>
  <ul>
    <% for member in @organisation.team: %>
      <li><%= @gravatar member.email, 32 %> <%= member.name %></li>
    <% end %>
  </ul>
  '

# the next both steps could be done in one by calling

# ecoTemplate = eco.render(template, data)

# generating a template function wich could be done in a precompilation step
# in this case we wouldn't need coffee-script.js and eco.js anymore.
ecoTemplate = eco template
# rendering the template by filling it with our dataset
ecoTemplate = ecoTemplate data

# appending the rendered template when document is loaded
$(document).ready ->
  $('.container').append ecoTemplate