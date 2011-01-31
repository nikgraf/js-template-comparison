(function() {
  var data, ecoTemplate, helpers, nik, template, tosh;
  helpers = {
    translate: function(key, language) {
      var depth, i, localize_path, localized, _ref;
      localize_path = key.split('.');
      depth = localize_path.length;
      localized = jQuery.global.localize(localize_path[0], language);
      for (i = 1, _ref = depth - 1; (1 <= _ref ? i <= _ref : i >= _ref); (1 <= _ref ? i += 1 : i -= 1)) {
        localized = localized[localize_path[i]];
      }
      return localized;
    },
    gravatar: function(email, size) {
      var hashed_email, src;
      hashed_email = md5(email);
      src = "http://www.gravatar.com/avatar/" + hashed_email + ".png";
      if (size) {
        src += "?s=" + size;
      }
      return this.safe("<img src=\"" + src + "\">");
    }
  };
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
  data.t = helpers.translate;
  data.gravatar = helpers.gravatar;
  $.global.preferCulture("en");
  $.global.localize("site", "en", {
    organisation: {
      since: 'since',
      type: 'type',
      type_list: {
        open_source: 'open source'
      },
      team: 'team'
    }
  });
  template = '\
  <h1><%= @organisation.name %></h1>\
\
  <dl>\
    <dt><%= @t "site.organisation.type" %></dt>\
    <dd><%= @t "site.organisation.type_list.#{@organisation.type}" %></dd>\
    <dt><%= @t "site.organisation.since" %></dt>\
    <dd><%= @organisation.since %></dd>\
  </dl>\
\
  <h2><%= @t "site.organisation.team" %></h2>\
  <ul>\
    <% for member in @organisation.team: %>\
      <li><%= @gravatar member.email, 32 %> <%= member.name %></li>\
    <% end %>\
  </ul>\
  ';
  ecoTemplate = eco(template);
  ecoTemplate = ecoTemplate(data);
  $(document).ready(function() {
    return $('.container').append(ecoTemplate);
  });
}).call(this);
