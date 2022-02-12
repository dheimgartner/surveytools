HTMLWidgets.widget({

  name: 'survey',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance
    var survey;

    return {

      renderValue: function(x) {

        // apply bootstrap
        Survey
          .StylesManager
          .applyTheme("bootstrap");

        // update survey object
        survey = new Survey.Model(x.survey_json);

        function alertResults(sender) {
          const results = JSON.stringify(sender.data);
          alert(results);
        }

        survey.onComplete.add(alertResults);

        $(function() {
          $(el).Survey({ model: survey });
        });

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      },

      // Make the survey object availabel as a property on the widget
      // instance -> allows for direct interaction if needed...
      s: survey

    };
  }
});



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
