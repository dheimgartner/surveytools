HTMLWidgets.widget({

  name: 'page',

  type: 'output',

  factory: function(el, width, height) {

    // define shared variables for this instance
    var page;
    var survey;
    var flag_init = false;
    var elementId = el.id;
    var container = document.getElementById(elementId);

    return {

      renderValue: function(x) {

        // TODO: survey is an htmlwidget and not a survey
        // object... HOW CAN WE ACCESS THE SURVEY OBJECT PROPERTY S???
        survey = x.survey;

        if(!flag_init) {
          flag_init = true;

          Survey
            .StylesManager
            .applyTheme('bootstrap');

          if(survey === null) {
            survey = new Survey.Model();
          }
          container.widget = this;
        }

        // create new page and add to survey
        page = survey.addNewPage('page');

        // shut off navigation
        survey.showNavigationButtons = false;

        // TODO: remove
        $(function() {
          $(el).Survey({ model: survey });
        });

        // API calls
        var numApiCalls = x['api'].length;
        for(var i = 0; i < numApiCalls; i++) {
          var call = x['api'][i];
          var method = call.method;
          // after deletion of method -> call == params
          delete call['method'];
          try {
            this[method](call);
          } catch(err) {}
        }

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      },

      // API
      addNewQuestion: function(params) {
        page.addNewQuestion(params.type, params.parameters)
      },

      addQuestion: function(params) {
        page.addQuestion(params.question)
      },

      // Make the object availabel as a property on the widget
      // instance -> allows for direct interaction if needed...
      p: survey

    };
  }
});

// shiny API
if (HTMLWidgets.shinyMode) {
  var fxns = ['addNewQuestion'];

  var addShinyHandler = function(fxn) {
    return function() {
      Shiny.addCustomMessageHandler(
        "survey:" + fxn, function(message) {
          var el = document.getElementById(message.id);
          if (el) {
            el.widget[fxn](message);
          }
        }
      );
    };
  };

  for (var i = 0; i < fxns.length; i++) {
    addShinyHandler(fxns[i])();
  }
}
