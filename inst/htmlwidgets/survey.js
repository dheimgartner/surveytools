HTMLWidgets.widget({

  name: 'survey',

  type: 'output',

  factory: function(el, width, height) {

    // define shared variables for this instance
    var survey;
    var flag_init = false;
    var container = document.getElementById(el.id);
    var answer_tracker;

    return {

      renderValue: function(x) {
        if(!flag_init) {
          flag_init = true;

          // apply bootstrap
          Survey
            .StylesManager
            .applyTheme("bootstrap");

          // update survey object
          survey = new Survey.Model(x.survey_json);
          container.widget = this;

          answer_tracker = x['answers'];
        }

        $(function() {
          $(el).Survey({ model: survey });
        });

        // Now that the survey is initialized call any outstanding API
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

        // on complete write answer_tracker back to x
        function saveAnswers(sender) {
          x['answers'] = answer_tracker;
          // TODO: send to shiny here...
        }
        survey.onComplete.add(saveAnswers);
      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      },

      // API
      addNewPage: function(params) {
        survey.addNewPage(params.page_name);
      },

      setValue: function(params) {
        survey.setValue(params.name, params.value);
      },

      nextPage: function(params) {
        survey.nextPage();
      },

      dumpAnswers: function(params) {
        function attachAnswers(sender) {
          const answers = JSON.stringify(sender.data);
          answer_tracker = answers;
        }

        survey.onComplete.add(attachAnswers);
      },

      // Make the survey object availabel as a property on the widget
      // instance -> allows for direct interaction if needed...
      s: survey

    };
  }
});


// shiny API
if (HTMLWidgets.shinyMode) {
  var fxns = ['addNewPage', 'setValue', 'nextPage'];

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



/*
Survey
    .StylesManager
    .applyTheme("modern");

const surveyJson = {
    elements: [{
        name: "FirstName",
        title: "Enter your first name:",
        type: "text"
    }, {
        name: "LastName",
        title: "Enter your last name:",
        type: "text"
    }]
};

const survey = new Survey.Model(surveyJson);
survey.focusFirstQuestionAutomatic = false;

function alertResults (sender) {
    const results = JSON.stringify(sender.data);
    alert(results);
}

survey.onComplete.add(alertResults);

$(function() {
    $("#surveyContainer").Survey({ model: survey });
});
*/
