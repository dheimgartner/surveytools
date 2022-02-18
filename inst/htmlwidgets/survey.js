HTMLWidgets.widget({

  name: 'survey',

  type: 'output',

  factory: function(el, width, height) {

    // define shared variables for this instance
    var survey;
    var page;
    var question;
    var flag_init = false;
    var elementId = el.id;
    var container = document.getElementById(elementId);
    var shinyMode = HTMLWidgets.shinyMode;
    var answer_tracker;

    return {

      renderValue: function(x) {
        if(!flag_init) {
          flag_init = true;

          // apply bootstrap
          Survey
            .StylesManager
            .applyTheme('bootstrap');

          // init survey object
          if(x.survey_json === null) {
            survey = new Survey.Model();
          } else {
            survey = new Survey.Model(x.survey_json);
          }

          container.widget = this;

          /* redundant at the moment
          answer_tracker = x['answers'];
          */
        }

        // assign survey to dom
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

        /* redundant at the moment
        // on complete write answer_tracker back to x
        function saveAnswers(sender) {
          x['answers'] = answer_tracker;
          // TODO: send to shiny here (or below in API)...
        }
        survey.onComplete.add(saveAnswers);
        */
      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      },

      // API
      showNavigationButtons: function(params) {
        survey.showNavigationButtons = params.show;
      },

      addNewPage: function(params) {
        page = survey.addNewPage(params.name, params.index);
      },

      addNewQuestion: function(params) {
        question = page.addNewQuestion(params.questionType, params.name, params.index);
      },

      title: function(params) {
        question.title = params.title;
      },

      name: function(params) {
        question.name = params.name;
      },

      description: function(params) {
        question.description = params.description;
      },

      toJSON: function(params) {
        var json = survey.toJSON();
        console.log(json);
      },

      setValue: function(params) {
        survey.setValue(params.name, params.value);
      },

      nextPage: function(params) {
        survey.nextPage();
      },

      answersOnComplete: function(params) {
        if(shinyMode) {
          function attachAnswers(sender) {
            answer_tracker = JSON.stringify(sender.data);
            Shiny.onInputChange(elementId + '_answersOnComplete', answer_tracker);
          }
        } else {
          function attachAnswers(sender) {
            answer_tracker = JSON.stringify(sender.data);
          }
        }

        survey.onComplete.add(attachAnswers);
      },

      onValueChanged: function(params) {
        switch(params.tracking) {
          case 'on':
            if(shinyMode) {
              survey.onValueChanged.add(function(sender, options) {
                if(options.question.name == params.question_name) {
                  Shiny.onInputChange(elementId + '_' + params.question_name + '_onValueChanged',
                    options.question.value
                  );
                }
              })
            } else {
              // not really useful...
              survey.onValueChanged.add(function(sender, options) {
                alert(`${ options.question.name } changed to ${ options.question.value }`);
              });
            }
            break;
          case 'off':
            break;
        }
      },

      callback: function(params) {
        console.log("callback not implemented (survey not found)...");
      },

      // Make the survey object availabel as a property on the widget
      // instance -> allows for direct interaction if needed...
      s: survey

    };
  }
});


// shiny API
if (HTMLWidgets.shinyMode) {
  var fxns = ['addNewPage', 'setValue', 'nextPage', 'answersOnComplete', 'onValueChanged', 'callback'];

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



