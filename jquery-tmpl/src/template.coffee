# tmpl extension we use in our templates
$.extend($.tmpl.tag,
  # provides an easy way to access translations in jquery-global
  "t":
    _default:
      $2: 'null',
    # TODO check out why the second line is necessary and $1.split('.'); doesn't work the first time if
    # we use string concatination in a template tag
    open: "var localize_path = $1.split('.');
          if(typeof(localize_path) == 'string') {localize_path = localize_path.split('.');};
          var depth = localize_path.length;
          var localized = jQuery.global.localize(localize_path[0], $2);
          for(i = 1; i < depth; i++) { localized = localized[localize_path[i]]; };
          _.push(localized);"
  # generates a gravatar image by it's given email
  "gravatar":
    _default:
      $2: 'null',
    open: "hashed_email = md5(email);
          src = 'http://www.gravatar.com/avatar/' + hashed_email + '.png';
          if($2) { src += '?s=' + $2; };
          _.push('<img src=\"' + src + '\">');"
)

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
  <h1>${organisation.name}</h1>
  <dl>
    <dt>{{t "site.organisation.type" }}</dt>
    <dd>{{t "site.organisation.typeList." + organisation.type }}</dd>
    <dt>{{t "site.organisation.since" }}</dt>
    <dd>${organisation.since}</dd>
  </dl>

  <h2>{{t "site.organisation.team" }}</h2>
  <ul>
    {{each( i, member ) organisation.team}}
      <li>{{gravatar(32) member.email }} ${member.name}</li>
    {{/each}}
  </ul>
  '

# compile template
jqueryTemplate = $.template  null, template

# appending the rendered template when document is loaded
$(document).ready ->
  $('.container').append $.tmpl(jqueryTemplate, data)
