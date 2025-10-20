<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${empty pageTitle ? 'MoveEasy - Nền tảng đặt dịch vụ' : pageTitle}"/></title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        /* Reset & Cơ bản */
        * { margin: 0; padding: 0; box-sizing: border-box; }

        /* Design Tokens */
        :root {
            --primary-color: oklch(0.45 0.15 162);
            --primary-hover: oklch(0.40 0.15 162);
            --secondary-color: oklch(0.55 0.15 162);
            --accent-color: oklch(0.55 0.15 162);
            --background: oklch(1 0 0);
            --surface: oklch(0.97 0 0);
            --text-primary: oklch(0.35 0 0);
            --text-secondary: oklch(0.60 0 0);
            --border: oklch(0.9 0 0);
            --shadow: 0 1px 3px 0 rgba(0,0,0,0.1);
            --star-color: #f59e0b;
        }
        [data-theme="dark"] {
            --background: oklch(0.15 0 0);
            --surface: oklch(0.25 0 0);
            --text-primary: oklch(0.9 0 0);
            --text-secondary: oklch(0.7 0 0);
            --border: oklch(0.3 0 0);
        }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; line-height: 1.6; color: var(--text-primary); background-color: var(--background); transition: background-color .3s ease, color .3s ease; }

        /* Header */
        .header { background: var(--background); border-bottom: 1px solid var(--border); padding: 1rem 0; position: sticky; top: 0; z-index: 100; }
        .header-container { max-width: 1200px; margin: 0 auto; padding: 0 1rem; display: flex; justify-content: space-between; align-items: center; }
        .logo { display: flex; align-items: center; gap: .5rem; font-size: 1.5rem; font-weight: bold; color: var(--text-primary); text-decoration: none; }
        .logo-icon-wrapper { width: 32px; height: 32px; background: var(--primary-color); border-radius: .5rem; display: flex; align-items: center; justify-content: center; }
        .logo-icon { color: #fff; font-size: 1.2rem; }
        .nav-menu { display: flex; list-style: none; gap: 2rem; align-items: center; }
        .nav-menu a { color: var(--text-primary); text-decoration: none; font-weight: 500; transition: color .3s ease; }
        .nav-menu a:hover { color: var(--primary-color); }
        .header-actions { display: flex; align-items: center; gap: 1rem; }

        /* Dropdown */
        .dropdown { position: relative; display: inline-block; }
        .dropdown-toggle { background: none; border: none; cursor: pointer; padding: .5rem; border-radius: .5rem; transition: background-color .3s ease; position: relative; }
        .dropdown-toggle:hover { background: var(--surface); }
        .dropdown-menu { position: absolute; top: 100%; right: 0; background: var(--background); border: 1px solid var(--border); border-radius: .5rem; box-shadow: var(--shadow); min-width: 200px; z-index: 1000; display: none; }
        .dropdown-menu.show { display: block; }
        .dropdown-item { display: block; padding: .75rem 1rem; color: var(--text-primary); text-decoration: none; transition: background-color .3s ease; }
        .dropdown-item:hover { background: var(--surface); }
        .badge { position: absolute; top: -5px; right: -5px; background: #ef4444; color: #fff; border-radius: 50%; width: 18px; height: 18px; font-size: .75rem; display: flex; align-items: center; justify-content: center; }

        /* Nút */
        .btn { padding: .75rem 1.5rem; border-radius: .5rem; font-weight: 600; text-decoration: none; display: inline-block; transition: all .3s ease; border: none; cursor: pointer; }
        .btn-primary { background: var(--primary-color); color: #fff; }
        .btn-primary:hover { background: var(--primary-hover); }
        .btn-secondary { background: transparent; color: var(--text-primary); border: 1px solid var(--border); }
        .btn-secondary:hover { background: var(--surface); }

        /* Hero */
        .hero { padding: 6rem 0; text-align: center; background: var(--surface); }
        .hero-container { max-width: 1200px; margin: 0 auto; padding: 0 1rem; }
        .hero h1 { font-size: 3.5rem; font-weight: bold; margin-bottom: 1.5rem; color: var(--primary-color); }
        .hero p { font-size: 1.25rem; color: var(--text-secondary); margin-bottom: 2rem; max-width: 600px; margin-left: auto; margin-right: auto; }
        .hero-actions { display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap; }

        /* Tính năng */
        .features { padding: 4rem 0; background: var(--background); }
        .features-container { max-width: 1200px; margin: 0 auto; padding: 0 1rem; }
        .features h2 { text-align: center; font-size: 2.5rem; margin-bottom: 3rem; }

        /* Lời chứng thực */
        .testimonials { padding: 4rem 0; background: var(--surface); }
        .testimonials-grid { max-width: 1200px; margin: 0 auto; padding: 0 1rem; display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem; margin-top: 3rem; }
        .testimonial-card { background: var(--background); border: 1px solid var(--border); border-radius: 1rem; padding: 1.5rem; box-shadow: var(--shadow); display: flex; flex-direction: column; justify-content: space-between; }
        .testimonial-card p { font-style: italic; color: var(--text-primary); margin-bottom: 1rem; }
        .testimonial-meta { border-top: 1px solid var(--border); padding-top: 1rem; }
        .testimonial-meta strong { display: block; font-weight: 600; color: var(--primary-color); margin-bottom: .25rem; }
        .star-rating { color: var(--star-color); font-size: 1rem; }

        .features-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem; }
        .feature-card { background: var(--surface); border: 1px solid var(--border); border-radius: 1rem; padding: 2rem; text-align: center; transition: transform .3s ease, box-shadow .3s ease; }
        .feature-card:hover { transform: translateY(-5px); box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        .feature-icon { width: 60px; height: 60px; background: var(--primary-color); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; color: #fff; font-size: 1.5rem; }

        /* Footer */
        .footer { background: var(--surface); padding: 2rem 0; border-top: 1px solid var(--border); text-align: center; }

        /* Responsive */
        @media (max-width: 768px) {
            .nav-menu { display: none; }
            .hero h1 { font-size: 2.5rem; }
            .hero-actions { flex-direction: column; align-items: center; }
            .features-grid, .testimonials-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
<header class="header">
    <div class="header-container">
        <a href="#" class="logo">
            <div class="logo-icon-wrapper"><i class="fas fa-truck logo-icon"></i></div>
            <span><c:out value="${empty companyName ? 'MoveEasy' : companyName}"/></span>
        </a>

        <nav class="nav-menu">
            <li><a href="#services">Dịch vụ</a></li>
            <li><a href="#testimonials">Đánh giá</a></li>
            <li><a href="#pricing">Bảng giá</a></li>
            <li><a href="#about">Về chúng tôi</a></li>
            <li><a href="#contact">Liên hệ</a></li>
        </nav>

        <div class="header-actions">
            <div class="dropdown" id="notificationsDropdown">
                <button class="dropdown-toggle" onclick="toggleDropdown('notificationsDropdown')">
                    <span>🔔</span>
                    <c:if test="${notificationCount > 0}">
                        <span class="badge"><c:out value="${notificationCount}"/></span>
                    </c:if>
                </button>
                <div class="dropdown-menu">
                    <c:choose>
                        <c:when test="${not empty notifications}">
                            <c:forEach var="notification" items="${notifications}">
                                <a href="#" class="dropdown-item"><c:out value="${notification.message}"/></a>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <a href="#" class="dropdown-item">Đã tạo đặt chỗ mới</a>
                            <a href="#" class="dropdown-item">Yêu cầu báo giá đã được gửi</a>
                            <a href="#" class="dropdown-item">Lịch làm việc nhân viên đã thay đổi</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <button class="dropdown-toggle theme-toggle" onclick="toggleTheme()">
                <span class="sun-icon">☀️</span>
                <span class="moon-icon">🌙</span>
            </button>

            <div class="dropdown" id="userDropdown">
                <button class="dropdown-toggle" onclick="toggleDropdown('userDropdown')">
                    <img src="${not empty user and not empty user.avatar ? user.avatar : 'https://via.placeholder.com/32/2563eb/ffffff?text=U'}" alt="Ảnh đại diện người dùng" style="width:32px;height:32px;border-radius:50%;">
                </button>
                <div class="dropdown-menu">
                    <div style="padding:1rem;border-bottom:1px solid var(--border);">
                        <div style="font-weight:600;"><c:out value="${not empty user and not empty user.name ? user.name : 'Jane Doe'}"/></div>
                        <div style="font-size:.875rem;color:var(--text-secondary);"><c:out value="${not empty user and not empty user.role ? user.role : 'Khách hàng'}"/></div>
                    </div>
                    <a href="/profile" class="dropdown-item">👤 Hồ sơ</a>
                    <a href="/settings" class="dropdown-item">⚙️ Cài đặt</a>
                    <a href="/logout" class="dropdown-item">🚪 Đăng xuất</a>
                </div>
            </div>

            <a href="${pageContext.request.contextPath}/quotation" class="btn btn-primary">Đặt lịch chuyển dọn</a>
        </div>
    </div>
</header>

<section class="hero">
    <div class="hero-container">
        <h1><c:out value="${empty heroTitle ? 'Chuyển dọn nhẹ nhàng, dịch vụ tinh gọn' : heroTitle}"/></h1>
        <p><c:out value="${empty heroDescription ? 'Đặt dịch vụ chuyển dọn và di dời đồ đạc trực tuyến tức thì. Nhận báo giá chính xác và quản lý chi tiết chuyển dọn thật dễ dàng.' : heroDescription}"/></p>
        <div class="hero-actions">
            <a href="${pageContext.request.contextPath}/quotation" class="btn btn-primary">Nhận báo giá ngay</a>
            <a href="#services" class="btn btn-secondary">Dịch vụ của chúng tôi</a>
        </div>
    </div>
</section>

<section class="features" id="services">
    <div class="features-container">
        <h2>Các dịch vụ chuyển dọn liền mạch</h2>
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">⏱️</div>
                <h3>Báo giá tức thì</h3>
                <p>Nhập danh sách đồ đạc để nhận giá ngay. Không phí ẩn, không phải chờ đợi.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">📦</div>
                <h3>Đóng gói chuyên nghiệp</h3>
                <p>Tùy chọn đóng gói/khui hàng bởi đội ngũ được đào tạo, bảo vệ an toàn cho đồ quý giá.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🛡️</div>
                <h3>Xử lý an toàn</h3>
                <p>Chúng tôi chăm sóc mọi món đồ của bạn cẩn thận, kèm bảo hiểm đầy đủ để an tâm.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🚚</div>
                <h3>Vận chuyển tin cậy</h3>
                <p>Đội xe hiện đại và tài xế giàu kinh nghiệm đảm bảo giao hàng đúng hẹn, an toàn.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🛠️</div>
                <h3>Tháo lắp đồ nội thất</h3>
                <p>Hỗ trợ tháo lắp các đồ cồng kềnh như giường, tủ quần áo…</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🗺️</div>
                <h3>Phủ sóng toàn quốc</h3>
                <p>Hỗ trợ chuyển dọn nội thành và đường dài trên khắp cả nước.</p>
            </div>
        </div>
    </div>
</section>

<section class="testimonials" id="testimonials">
    <div class="features-container">
        <h2>Khách hàng nói gì</h2>
    </div>
    <div class="testimonials-grid">
        <div class="testimonial-card">
            <p>"Đội ngũ làm việc cực nhanh và chuyên nghiệp. Họ xử lý mọi đồ dễ vỡ của tôi rất cẩn thận. Quy trình báo giá online thực sự thay đổi cuộc chơi!"</p>
            <div class="testimonial-meta">
                <div class="star-rating">
                    <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                </div>
                <strong>— Alice H.</strong>
                <span style="font-size:.875rem;color:var(--text-secondary);">Chuyển nhà nội thành (4.8 sao)</span>
            </div>
        </div>
        <div class="testimonial-card">
            <p>"Trải nghiệm liền mạch từ đặt lịch đến giao đồ. Nhân viên lịch sự, đúng giờ và làm việc rất hiệu quả. Rất đáng để giới thiệu MoveEasy!"</p>
            <div class="testimonial-meta">
                <div class="star-rating">
                    <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
                </div>
                <strong>— Ben M.</strong>
                <span style="font-size:.875rem;color:var(--text-secondary);">Chuyển liên tỉnh (4.5 sao)</span>
            </div>
        </div>
        <div class="testimonial-card">
            <p>"Tôi dùng thêm dịch vụ đóng gói và tiết kiệm được rất nhiều thời gian, giảm hẳn căng thẳng. Mọi thứ đến nơi nguyên vẹn. Đáng đồng tiền."</p>
            <div class="testimonial-meta">
                <div class="star-rating">
                    <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                </div>
                <strong>— Clara D.</strong>
                <span style="font-size:.875rem;color:var(--text-secondary);">Chuyển căn hộ (5.0 sao)</span>
            </div>
        </div>
        <div class="testimonial-card">
            <p>"Hệ thống báo giá rất minh bạch và giá cuối cùng khớp hoàn toàn với ước tính. Không có bất ngờ nào cả!"</p>
            <div class="testimonial-meta">
                <div class="star-rating">
                    <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i>
                </div>
                <strong>— David K.</strong>
                <span style="font-size:.875rem;color:var(--text-secondary);">Chuyển văn phòng nhỏ (4.0 sao)</span>
            </div>
        </div>
        <div class="testimonial-card">
            <p>"Giao tiếp rất tốt trong suốt quá trình. Họ linh hoạt khi ngày chuyển của tôi thay đổi một chút."</p>
            <div class="testimonial-meta">
                <div class="star-rating">
                    <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                </div>
                <strong>— Emma L.</strong>
                <span style="font-size:.875rem;color:var(--text-secondary);">Chuyển nhà nguyên căn (5.0 sao)</span>
            </div>
        </div>
    </div>
</section>

<footer class="footer">
    <div style="max-width:1200px;margin:0 auto;padding:0 1rem;">
        <p>&copy; 2025 <c:out value="${empty companyName ? 'MoveEasy' : companyName}"/>. Đã đăng ký bản quyền.</p>
    </div>
</footer>

<script>
    function toggleDropdown(id){
        const dropdown=document.getElementById(id);
        const menu=dropdown.querySelector('.dropdown-menu');
        document.querySelectorAll('.dropdown-menu').forEach(m=>{ if(m!==menu){ m.classList.remove('show'); }});
        menu.classList.toggle('show');
    }
    document.addEventListener('click',function(e){ if(!e.target.closest('.dropdown')){ document.querySelectorAll('.dropdown-menu').forEach(m=>m.classList.remove('show')); }});
    function toggleTheme(){
        const current=document.documentElement.getAttribute('data-theme');
        const next=current==='dark'?'light':'dark';
        document.documentElement.setAttribute('data-theme',next);
        localStorage.setItem('theme',next);
    }
    document.addEventListener('DOMContentLoaded',function(){
        const saved=localStorage.getItem('theme')||'light';
        document.documentElement.setAttribute('data-theme',saved);
    });
    document.querySelectorAll('a[href^="#"]').forEach(a=>{
        a.addEventListener('click',function(e){
            e.preventDefault();
            const target=document.querySelector(this.getAttribute('href'));
            document.querySelectorAll('.dropdown-menu').forEach(m=>m.classList.remove('show'));
            if(target){ target.scrollIntoView({behavior:'smooth',block:'start'}); }
        });
    });
</script>
</body>
</html>
