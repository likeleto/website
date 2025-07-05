// Wiki Links Hover Previews
document.addEventListener('DOMContentLoaded', function() {
    const wikiLinks = document.querySelectorAll('.wiki-link');
    
    wikiLinks.forEach(link => {
        const title = link.getAttribute('data-title');
        const excerpt = link.getAttribute('data-excerpt');
        
        if (title && excerpt) {
            link.addEventListener('mouseenter', function(e) {
                showPreview(e.target, title, excerpt);
            });
            
            link.addEventListener('mouseleave', function() {
                hidePreview();
            });
        }
    });
    
    function showPreview(link, title, excerpt) {
        // Remove any existing preview
        hidePreview();
        
        const preview = document.createElement('div');
        preview.className = 'wiki-link-preview';
        preview.innerHTML = `
            <div class="preview-content">
                <strong>${title}</strong>
                <p>${excerpt}</p>
            </div>
        `;
        
        document.body.appendChild(preview);
        
        // Position the preview near the link
        const rect = link.getBoundingClientRect();
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        
        preview.style.position = 'absolute';
        preview.style.left = rect.left + 'px';
        preview.style.top = (rect.bottom + scrollTop + 5) + 'px';
        preview.style.zIndex = '1000';
        
        // Add fade-in animation
        preview.style.opacity = '0';
        preview.style.transform = 'translateY(-10px)';
        preview.style.transition = 'opacity 0.2s ease, transform 0.2s ease';
        
        setTimeout(() => {
            preview.style.opacity = '1';
            preview.style.transform = 'translateY(0)';
        }, 10);
    }
    
    function hidePreview() {
        const existingPreview = document.querySelector('.wiki-link-preview');
        if (existingPreview) {
            existingPreview.style.opacity = '0';
            existingPreview.style.transform = 'translateY(-10px)';
            setTimeout(() => {
                existingPreview.remove();
            }, 200);
        }
    }
}); 