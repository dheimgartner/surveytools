HTMLWidgets.widget({

  name: 'radiogroup',

  type: 'output',

  factory: function(el, width, height) {

    // define shared variables for this instance
    var question;
    var flag_init = false;
    var elementId = el.id;
    var container = document.getElementById(elementId);
    var answer_tracker;
    var page;

    return {

      renderValue: function(x) {

        // retrieve survey.page from x.page!
        page = x.page;

        // render the "survey"

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
