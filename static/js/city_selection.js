document.addEventListener("DOMContentLoaded", function() {
    const citySearch = document.getElementById("citySearch");
    const cityList = document.getElementById("cityList");
    const allCities = document.querySelectorAll(".city");


    allCities.forEach(city => {
        city.addEventListener("click", function() {
            let cityId = this.dataset.cityId; 
            console.log("City selected:", cityId);

            if (cityId) {
                document.getElementById("selectedCityId").value = cityId;
                document.getElementById("cityForm").submit(); 
            } else {
                console.error("❌ No city ID found!");
            }
        });
    });

    
    citySearch.addEventListener("input", function() {
        let searchQuery = citySearch.value.toLowerCase();

        allCities.forEach(city => {
            let cityName = city.textContent.toLowerCase();
            if (cityName.includes(searchQuery)) {
                city.style.display = "block";
                
            } else {
                city.style.display = "none"; 
            }
        });
    });
});
