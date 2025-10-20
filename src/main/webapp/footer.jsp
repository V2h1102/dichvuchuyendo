<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="bg-card border-t border-border py-12">
    <div class="container mx-auto px-4 sm:px-6 lg:px-8 text-center text-muted-foreground">
        <p>&copy; 2025 MoveEasy. Tất cả quyền được bảo lưu.</p>
    </div>
</footer>

<script>
    function toggleDropdown(dropdownId) {
        const dropdown = document.getElementById(dropdownId);
        document.querySelectorAll('.dropdown-content').forEach(other => {
            if (other.id !== dropdownId) other.classList.add('hidden');
        });
        dropdown.classList.toggle('hidden');
    }
    document.addEventListener('click', function(event) {
        if (!event.target.closest('.dropdown')) {
            document.querySelectorAll('.dropdown-content').forEach(d => d.classList.add('hidden'));
        }
    });
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        });
    });
</script>
</body>
</html>