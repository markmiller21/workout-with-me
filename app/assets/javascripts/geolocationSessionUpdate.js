        $(document).ready(function() {

        var latitude = document.getElementById("lat");
        var longitude = document.getElementById("long");

        function getLocation() {
          if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(showPosition);
          } else {
            latitude.innerHTML = "Geolocation is not supported by this browser.";
          }
        }
        function showPosition(position) {
          latitude.value = position.coords.latitude;
          longitude.value = position.coords.longitude;
        }
        $('#location_session').on('click',function(){
          var pos = getLocation();
          showPosition(pos);
      })
      });
