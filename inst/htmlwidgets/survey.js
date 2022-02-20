HTMLWidgets.widget({

    name: 'survey',

    type: 'output',

    factory: function(el, width, height) {

        // define shared variables for this instance
        var survey;
        var page;
        var question;
        var flag_init = false;
        var flag_json = false;
        var elementId = el.id;
        var container = document.getElementById(elementId);
        var shinyMode = HTMLWidgets.shinyMode;
        var answer_tracker;
        var api;

        return {

            renderValue: function(x) {
                if (!flag_init) {
                    flag_init = true;

                    // apply bootstrap
                    Survey
                        .StylesManager
                        .applyTheme('bootstrap');

                    // init survey object
                    if (x.survey_json === null) {
                        survey = new Survey.Model();
                    }
                    else {
                        flag_json = true;
                        survey = new Survey.Model(x.survey_json);
                    }

                    container.widget = this;
                    api = x.api;

                    /* redundant at the moment
                    answer_tracker = x['answers'];
                    */
                }

                // assign survey to dom
                $(function() {
                    $(el).Survey({
                        model: survey
                    });
                });

                // Now that the survey is initialized call any outstanding API
                var numApiCalls = x['api'].length;
                for (var i = 0; i < numApiCalls; i++) {
                    var call = x['api'][i];
                    var method = call.method;
                    // after deletion of method -> call == params
                    delete call['method'];
                    try {
                        this[method](call);
                    } catch (err) {}
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
            // Survey
            locale: function(params) {
                survey.locale = params.locale;
            },

            showNavigationButtons: function(params) {
                survey.showNavigationButtons = params.showNavigationButtons;
            },

            showQuestionNumbers: function(params) {
                survey.showQuestionNumbers = params.showQuestionNumbers;
            },

            showProgressBar: function(params) {
                survey.showProgressBar = params.showProgressBar;
            },

            addNewPage: function(params) {
                page = survey.addNewPage(params.name, params.index);
            },

            nextPage: function(params) {
                survey.nextPage();
            },

            // Questions
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

            isRequired: function(params) {
                question.isRequired = true;
            },

            requiredErrorText: function(params) {
                question.requiredErrorText = params.requiredErrorText;
            },

            placeHolder: function(params) {
                question.placeHolder = params.placeHolder;
            },

            visibleIf: function(params) {
                question.visibleIf = params.expression;
            },

            requiredIf: function(params) {
                question.requiredIf = params.expression;
            },

            cssClasses: function(params) {
                var message = `cssClasses:\n${JSON.stringify(question.cssClasses)}`;
                alert(message);
            },

            defaultValue: function(params) {
                question.defaultValue = params.defaultValue;
            },

            inputType: function(params) {
                question.inputType = params.inputType;
            },

            max: function(params) {
                question.max = params.max;
            },

            maxErrorText: function(params) {
                question.maxErrorText = params.maxErrorText;
            },

            min: function(params) {
                question.min = params.min;
            },

            minErrorText: function(params) {
                question.minErrorText = params.minErrorText;
            },

            size: function(params) {
                question.size = params.size;
            },

            choices: function(params) {
                question.choices = params.choices;
            },

            noneText: function(params) {
                question.hasNone = true;
                question.noneText = params.noneText;
            },

            otherPlaceHolder: function(params) {
                question.hasOther = true;
                question.otherPlaceHolder = params.otherPlaceHolder;
            },

            otherText: function(params) {
                question.hasOther = true;
                question.otherText = params.otherText;
            },

            getAllQuestions: function(params) {
                var message = `getAllQuestions:\n${JSON.stringify(survey.getAllQuestions())}`;
                alert(message);
            },

            // Answers
            toJSON: function(params) {
                var message = `toJSON:\n${JSON.stringify(survey.toJSON())}`;
                alert(message);
            },

            setValue: function(params) {
                survey.setValue(params.name, params.value);
            },

            answersOnComplete: function(params) {
                if (shinyMode) {
                    function attachAnswers(sender) {
                        console.log('blobb');
                        answer_tracker = JSON.stringify(sender.data);
                        Shiny.onInputChange(elementId + '_answersOnComplete', answer_tracker);
                    }
                }
                else {
                    function attachAnswers(sender) {
                        answer_tracker = JSON.stringify(sender.data);
                        alert(JSON.stringify(answer_tracker));
                    }
                }

                survey.onComplete.add(attachAnswers);
            },

            doComplete: function(params) {
                try {
                    survey.doComplete();
                } catch(error) {
                    console.error(error);
                }
            },

            onValueChanged: function(params) {
                var name = (flag_json) ? params.name : question.name;

                if (flag_json) {
                    if (params.name === null) console.error("no params.name passed to onValueChanged!");
                }

                survey.onValueChanged.add(function(sender, options) {
                    if (shinyMode) {
                        // shiny mode
                        if (flag_json) {
                            if (options.question.name == name) {
                                Shiny.onInputChange(elementId + '_' + name + '_onValueChanged',
                                    options.question.value
                                );
                            }
                        } else {
                            // pipe mode
                            if (options.question.name == name) {
                                Shiny.onInputChange(elementId + '_' + name + '_onValueChanged',
                                    options.question.value
                                );
                            }
                        }
                    } else {
                        // not in shiny mode
                        if (flag_json) {
                            // survey_json mode
                            if (options.question.name == name) {
                                alert(`${ options.question.name } changed to ${ options.question.value }`);
                            }
                        } else {
                            // pipe mode
                            if (options.question.name == name) {
                                alert(`${ options.question.name } changed to ${ options.question.value }`);
                            }
                        }
                    }
                });
            },

            // Other
            completedHtml: function(params) {
              survey.completedHtml = params.completedHtml;
            },

            showCompletedPage: function(params) {
              survey.showCompletedPage = params.showCompletedPage;
            },

            callback: function(params) {
                switch(params.object) {
                    case 'survey':
                        params.JS(survey = survey);
                        break;
                    case 'page':
                        params.JS(page = page);
                        break;
                    case 'question':
                        params.JS(question = question);
                        break;
                    default:
                        params.JS();
                } 
            },

            // Make the survey object availabel as a property on the widget
            // instance -> allows for direct interaction if needed... return from factory
            survey: survey

        };
    }
});


// shiny API
if (HTMLWidgets.shinyMode) {
    var fxns = ['locale',
        'showNavigationButtons',
        'showQuestionNumbers',
        'showProgressBar',
        'addNewPage',
        'addNewQuestion',
        'title',
        'name',
        'description',
        'isRequired',
        'requiredErrorText',
        'placeHolder',
        'visibleIf',
        'requiredIf',
        'cssClasses',
        'defaultValue',
        'inputType',
        'max',
        'maxErrorText',
        'min',
        'minErrorText',
        'choices',
        'noneText',
        'otherPlaceHolder',
        'otherText',
        'getAllQuestions',
        'toJSON',
        'setValue',
        'nextPage',
        'answersOnComplete',
        'doComplete',
        'onValueChanged',
        'callback'
    ];

    var addShinyHandler = function(fxn) {
        return function() {
            Shiny.addCustomMessageHandler(
                "survey:" + fxn,
                function(message) {
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
