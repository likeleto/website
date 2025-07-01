document.addEventListener('DOMContentLoaded', function() {
    const badgeContainer = document.getElementById('typeBadges');
    const libraryItems = document.querySelectorAll('.library-item');

    // Collect all unique types from library items
    const types = new Set();
    libraryItems.forEach(item => {
        const itemType = item.getAttribute('data-type');
        if (itemType) types.add(itemType);
    });
    const sortedTypes = Array.from(types).sort();
    const options = ['all', ...sortedTypes];

    // Generate badges
    badgeContainer.innerHTML = '';
    options.forEach(type => {
        const badge = document.createElement('button');
        badge.className = 'filter-badge' + (type === 'all' ? ' active' : '');
        badge.setAttribute('data-type', type);
        badge.type = 'button';
        badge.textContent = type.charAt(0).toUpperCase() + type.slice(1);
        badgeContainer.appendChild(badge);
    });

    // Badge click handler
    badgeContainer.addEventListener('click', function(e) {
        if (e.target.classList.contains('filter-badge')) {
            const selectedType = e.target.getAttribute('data-type');
            badgeContainer.querySelectorAll('.filter-badge').forEach(b => b.classList.remove('active'));
            e.target.classList.add('active');
            libraryItems.forEach(item => {
                const itemType = item.getAttribute('data-type');
                if (selectedType === 'all' || itemType === selectedType) {
                    item.style.display = 'flex';
                } else {
                    item.style.display = 'none';
                }
            });
        }
    });
}); 