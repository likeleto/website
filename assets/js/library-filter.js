document.addEventListener('DOMContentLoaded', function() {
    const badgeContainer = document.getElementById('typeBadges');
    const libraryItems = document.querySelectorAll('.library-item');

    // Collect all unique types from library items and count them
    const typeCounts = {};
    libraryItems.forEach(item => {
        const itemType = item.getAttribute('data-type');
        if (itemType) {
            typeCounts[itemType] = (typeCounts[itemType] || 0) + 1;
        }
    });
    
    const sortedTypes = Object.keys(typeCounts).sort();
    const options = ['all', ...sortedTypes];

    // Generate badges
    badgeContainer.innerHTML = '';
    options.forEach(type => {
        const badge = document.createElement('button');
        badge.className = 'filter-badge' + (type === 'all' ? ' active' : '');
        badge.setAttribute('data-type', type);
        badge.type = 'button';
        
        // Set badge text with count
        if (type === 'all') {
            const totalCount = libraryItems.length;
            badge.innerHTML = `All <span class="library-date">${totalCount}</span>`;
        } else {
            const count = typeCounts[type];
            const typeLabel = type.charAt(0).toUpperCase() + type.slice(1);
            badge.innerHTML = `${typeLabel} <span class="library-date">${count}</span>`;
        }
        
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