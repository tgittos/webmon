var tour = {
  id: "onboarding",
  steps: [
    {
      title: "Lets get started!",
      content: "Lets get started monitoring websites. Click here to add a website",
      target: "new-site",
      placement: "left",
      multipage: true,
      showNextButton: false
    },
    {
      title: "Give your site a name",
      target: "site_name",
      placement: "right",
      nextOnTargetClick: true,
      showNextButton: false
    },
    {
      title: "Enter the site's URL",
      target: "site_url",
      placement: "right",
      nextOnTargetClick: true,
      showNextButton: false
    },
    {
      title: "Click here to save your site",
      target: "create-site",
      placement: "right",
      multipage: true,
      showNextButton: false
    },
    {
      title: "Site Dashboard",
      content: "Here you can see an overall view of your site's health. Right now there are no tests. Lets add one.",
      target: "site-title",
      placement: "bottom"
    },
    {
      title: "Click here to add a test",
      target: "new-test",
      placement: "top",
      xOffset: -200,
      arrowOffset: 200,
      multipage: true,
      showNextButton: false
    },
    { 
      title: "Choose how to compare",
      target: ['content_test_comparison', 'response_test_comparison', 'response_time_test_comparison'],
      description: "Select how to compare the value you're testing for",
      placement: "right",
      nextOnTargetClick: true,
      showNextButton: false
    },
    {
      title: "Select value to test against",
      target: ['content_test_content', 'response_test_content', 'response_time_test_content'],
      placement: "right",
      nextOnTargetClick: true,
      showNextButton: false
    },
    {
      title: "Create your test",
      target: "create-test",
      placement: "right",
      multipage: true,
      showNextButton: false
    },
    {
      title: "You've just added a test!",
      content: "Great work! On this test page, you can track the history of your test",
      target: "results",
      placement: "right",
      multipage: true,
      onNext: function(){
        window.location = '/sites';
      }
    },
    {
      title: "Go forth and monitor!",
      target: [".ok", ".warning", ".error"],
      content: "As tests fail, these icons will change to indicate status. We'll also send you an email if it fails the configured number of times. That concludes this tour!",
      placement: "bottom",
      onNext: function(){
        hopscotch.endTour();
      }
    }
  ]
};

$(document).on('ready page:partial-load', function(){
  if (hopscotch.getState() === "onboarding:0") {
    hopscotch.startTour(tour, 0);
  }
  else if (hopscotch.getState() === "onboarding:3") {
    hopscotch.startTour(tour, 3);
  }
  else if (hopscotch.getState() === "onboarding:5") {
    hopscotch.startTour(tour, 5);
  }
  else if (hopscotch.getState() === "onboarding:8") {
    hopscotch.startTour(tour, 8);
  }
  else if (hopscotch.getState() === "onboarding:10") {
    hopscotch.startTour(tour, 10);
  }
  else if (window.location.pathname === '/sites' && $('h2').length == 0) {
    hopscotch.startTour(tour);
  }
});
