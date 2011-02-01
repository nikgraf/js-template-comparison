(function() {
  var data, jqueryTemplate, nik, template, tosh;
  $.extend($.tmpl.tag, {
    "t": {
      _default: {
        $2: 'null'
      },
      open: "var localize_path = $1.split('.');          if(typeof(localize_path) == 'string') {localize_path = localize_path.split('.');};          var depth = localize_path.length;          var localized = jQuery.global.localize(localize_path[0], $2);          for(i = 1; i < depth; i++) { localized = localized[localize_path[i]]; };          _.push(localized);"
    },
    "gravatar": {
      _default: {
        $2: 'null'
      },
      open: "hashed_email = md5(email);          src = 'http://www.gravatar.com/avatar/' + hashed_email + '.png';          if($2) { src += '?s=' + $2; };          _.push('<img src=\"' + src + '\">');"
    }
  });
  data = {
    organisation: {
      name: 'Brunch ~ with coffee',
      type: 'open_source',
      since: 2011,
      team: [
        nik = {
          name: "Nik Graf",
          email: "nik" + "@" + "deck.cc"
        }, tosh = {
          name: "Tosh",
          email: "tosh" + "@" + "deck.cc"
        }
      ]
    }
  };
  $.global.preferCulture("en");
  $.global.localize("site", "en", {
    organisation: {
      since: 'since',
      type: 'type',
      typeList: {
        open_source: 'open source'
      },
      team: 'team'
    }
  });
  template = '\
  <h1>${organisation.name}</h1>\
  <dl>\
    <dt>{{t "site.organisation.type" }}</dt>\
    <dd>{{t "site.organisation.typeList." + organisation.type }}</dd>\
    <dt>{{t "site.organisation.since" }}</dt>\
    <dd>${organisation.since}</dd>\
  </dl>\
\
  <h2>{{t "site.organisation.team" }}</h2>\
  <ul>\
    {{each( i, member ) organisation.team}}\
      <li>{{gravatar(32) member.email }} ${member.name}</li>\
    {{/each}}\
  </ul>\
  ';
  jqueryTemplate = $.template(null, template);
  $(document).ready(function() {
    return $('.container').append($.tmpl(jqueryTemplate, data));
  });
}).call(this);
