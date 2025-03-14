document.addEventListener("DOMContentLoaded", function() {
    const citySearch = document.getElementById("citySearch");
    const cityList = document.getElementById("cityList");
    const allCities = document.querySelectorAll(".city");

    // ✅ City selection logic
    allCities.forEach(city => {
        city.addEventListener("click", function() {
            let cityId = this.dataset.cityId; // ✅ Get correct city ID
            console.log("City selected:", cityId); // ✅ Debugging output

            if (cityId) {
                document.getElementById("selectedCityId").value = cityId;
                document.getElementById("cityForm").submit(); // ✅ Auto-submit form
            } else {
                console.error("❌ No city ID found!");
            }
        });
    });

    // ✅ Search functionality
    citySearch.addEventListener("input", function() {
        let searchQuery = citySearch.value.toLowerCase();

        allCities.forEach(city => {
            let cityName = city.textContent.toLowerCase();
            if (cityName.includes(searchQuery)) {
                city.style.display = "block"; // Show matching city
            } else {
                city.style.display = "none"; // Hide non-matching city
            }
        });
    });
});
