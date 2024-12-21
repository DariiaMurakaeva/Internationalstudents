document.addEventListener("DOMContentLoaded", () => {
    const contentSection = document.getElementById("content-section");
    const toggleCreated = document.getElementById("toggle-created");
    const toggleSaved = document.getElementById("toggle-saved");
    const togglePosts = document.getElementById("toggle-posts");
    const toggleDiscussions = document.getElementById("toggle-discussions");
    const isAdmin = contentSection.dataset.isAdmin === "true";
    const profileId = contentSection.dataset.profileId;

    function updateContent() {
        const isCreated = toggleCreated.checked;
        const isPosts = togglePosts.checked;

        const contentType = isCreated ? "created" : "saved";
        const category = isPosts ? "posts" : "discussions";

        console.log(`Fetching content: ${contentType}, ${category}`);

    fetch(`/profiles/${profileId}/content?content_type=${contentType}&category=${category}`, {
        headers: { "Accept": "application/json" },
    })
        .then((response) => {
            if (!response.ok) {
                throw new Error(`Network response was not ok: ${response.statusText}`);
            }
                return response.json();
        })
        .then((data) => {
            console.log("Received data:", data);
            contentSection.innerHTML = data.html;

          // Disable the "Posts" toggle for non-admin users when "Created" is selected
            togglePosts.disabled = !isAdmin && isCreated;
        })
        .catch((error) => {
            console.error("Error loading content:", error);
        });
    }

    // Attach event listeners to toggle switches
    toggleCreated.addEventListener("change", updateContent);
    toggleSaved.addEventListener("change", updateContent);
    togglePosts.addEventListener("change", updateContent);
    toggleDiscussions.addEventListener("change", updateContent);
    
    // Initialize content on page load
    updateContent();
});  