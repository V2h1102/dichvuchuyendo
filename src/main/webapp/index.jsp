<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Dịch Vụ Chuyển Nhà - MoveEasy'}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        background: 'oklch(1 0 0)',
                        foreground: 'oklch(0.35 0 0)',
                        card: 'oklch(0.97 0 0)',
                        'card-foreground': 'oklch(0.35 0 0)',
                        primary: 'oklch(0.45 0.15 162)',
                        'primary-foreground': 'oklch(1 0 0)',
                        secondary: 'oklch(0.55 0.15 162)',
                        'secondary-foreground': 'oklch(1 0 0)',
                        muted: 'oklch(0.97 0 0)',
                        'muted-foreground': 'oklch(0.35 0 0)',
                        accent: 'oklch(0.55 0.15 162)',
                        'accent-foreground': 'oklch(1 0 0)',
                        border: 'oklch(0.9 0 0)',
                        input: 'oklch(1 0 0)',
                        ring: 'oklch(0.45 0.15 162 / 0.5)'
                    }
                }
            }
        }
    </script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-background text-foreground">
    <!-- Hero Section -->
    <section class="relative bg-gradient-to-br from-primary/10 via-background to-secondary/10 py-20">
        <div class="container mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center max-w-4xl mx-auto">
                <h1 class="text-4xl md:text-6xl font-bold text-foreground mb-6">
                    ${heroTitle != null ? heroTitle : 'Dịch Vụ Chuyển Nhà Chuyên Nghiệp'}
                </h1>
                <p class="text-xl md:text-2xl text-muted-foreground mb-8 leading-relaxed">
                    ${heroDescription != null ? heroDescription : 'Chuyển nhà an toàn, nhanh chóng và tiết kiệm với đội ngũ nhân viên chuyên nghiệp. Chúng tôi cam kết bảo vệ đồ đạc của bạn như của chính mình.'}
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="booking.html" class="bg-primary hover:bg-primary/90 text-primary-foreground px-8 py-4 rounded-lg font-semibold text-lg transition-colors inline-flex items-center justify-center">
                        <i class="fas fa-calendar-plus mr-2"></i>
                        Đặt Lịch Ngay
                    </a>
                    <a href="#services" class="bg-card hover:bg-card/80 text-card-foreground border border-border px-8 py-4 rounded-lg font-semibold text-lg transition-colors inline-flex items-center justify-center">
                        <i class="fas fa-info-circle mr-2"></i>
                        Tìm Hiểu Thêm
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Services Section -->
    <section id="services" class="py-16">
        <div class="container mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-12">
                <h2 class="text-3xl md:text-4xl font-bold text-foreground mb-4">Dịch Vụ Của Chúng Tôi</h2>
                <p class="text-xl text-muted-foreground max-w-2xl mx-auto">
                    Cung cấp đầy đủ các dịch vụ chuyển nhà từ cơ bản đến cao cấp
                </p>
            </div>

            <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
                <!-- Service 1 -->
                <div class="bg-card p-8 rounded-xl shadow-sm border border-border hover:shadow-md transition-shadow">
                    <div class="w-16 h-16 bg-primary/10 rounded-lg flex items-center justify-center mb-6">
                        <i class="fas fa-truck text-primary text-2xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold text-card-foreground mb-4">Chuyển Nhà Cơ Bản</h3>
                    <p class="text-muted-foreground mb-6">
                        Dịch vụ chuyển nhà tiết kiệm với xe tải nhỏ, phù hợp cho căn hộ 1-2 phòng ngủ.
                    </p>
                    <ul class="space-y-2 text-sm text-muted-foreground">
                        <li class="flex items-center"><i class="fas fa-check text-primary mr-2"></i>Xe tải nhỏ</li>
                        <li class="flex items-center"><i class="fas fa-check text-primary mr-2"></i>2 nhân viên</li>
                        <li class="flex items-center"><i class="fas fa-check text-primary mr-2"></i>Bảo hiểm cơ bản</li>
                    </ul>
                </div>

                <!-- Service 2 -->
                <div class="bg-card p-8 rounded-xl shadow-sm border border-border hover:shadow-md transition-shadow">
                    <div class="w-16 h-16 bg-primary/10 rounded-lg flex items-center justify-center mb-6">
                        <i class="fas fa-home text-primary text-2xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold text-card-foreground mb-4">Chuyển Nhà Tiêu Chuẩn</h3>
                    <p class="text-muted-foreground mb-6">
                        Dịch vụ chuyển nhà đầy đủ với xe tải lớn, phù hợp cho nhà 3-4 phòng ngủ.
                    </p>
                    <ul class="space-y-2 text-sm text-muted-foreground">
                        <li class="flex items-center"><i class="fas fa-check text-primary mr-2"></i>Xe tải lớn</li>
                        <li class="flex items-center"><i class="fas fa-check text-primary mr-2"></i>3-4 nhân viên</li>
                        <li class="flex items-center"><i class="fas fa-check text-primary mr-2"></i>Bảo hiểm đầy đủ</li>
                    </ul>
                </div>

                <!-- Service 3 -->
                <div class="bg-card p-8 rounded-xl shadow-sm border border-border hover:shadow-md transition-shadow">
                    <div class="w-16 h-16 bg-primary/10 rounded-lg flex items-center justify-center mb-6">
                        <i class="fas fa-crown text-primary text-2xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold text-card-foreground mb-4">Chuyển Nhà Cao Cấp</h3>
                    <p class="text-muted-foreground mb-6">
                        Dịch vụ chuyển nhà cao cấp với đầy đủ tiện ích và bảo hiểm toàn diện.
                    </p>
                    <ul class="space-y-2 text-sm text-muted-foreground">
                        <li class="flex items-center"><i class="fas fa-check text-primary mr-2"></i>Xe tải lớn + xe phụ</li>
                        <li class="flex items-center"><i class="fas fa-check text-primary mr-2"></i>5-6 nhân viên</li>
                        <li class="flex items-center"><i class="fas fa-check text-primary mr-2"></i>Bảo hiểm toàn diện</li>
                    </ul>
                </div>

                <!-- Service 4 -->
                <div class="bg-card p-8 rounded-xl shadow-sm border border-border hover:shadow-md transition-shadow">
                    <div class="w-16 h-16 bg-primary/10 rounded-lg flex items-center justify-center mb-6">
                        <i class="fas fa-box text-primary text-2xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold text-card-foreground mb-4">Đóng Gói Đồ Đạc</h3>
                    <p class="text-muted-foreground mb-6">
                        Dịch vụ đóng gói chuyên nghiệp với vật liệu bảo vệ cao cấp.
                    </p>
                    <ul class="space-y-2 text-sm text-muted-foreground">
                        <li class="flex items-center"><i class="fas fa-check text-primary mr-2"></i>Vật liệu đóng gói</li>
                        <li class="flex items-center"><i class="fas fa-check text-primary mr-2"></i>Nhân viên chuyên nghiệp</li>
                        <li class="flex items-center"><i class="fas fa-check text-primary mr-2"></i>Bảo vệ đồ dễ vỡ</li>
                    </ul>
                </div>

                <!-- Service 5 -->
                <div class="bg-card p-8 rounded-xl shadow-sm border border-border hover:shadow-md transition-shadow">
                    <div class="w-16 h-16 bg-primary/10 rounded-lg flex items-center justify-center mb-6">
                        <i class="fas fa-warehouse text-primary text-2xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold text-card-foreground mb-4">Lưu Kho Tạm Thời</h3>
                    <p class="text-muted-foreground mb-6">
                        Dịch vụ lưu kho an toàn cho đồ đạc trong quá trình chuyển nhà.
                    </p>
                    <ul class="space-y-2 text-sm text-muted-foreground">
                        <li class="flex items-center"><i class="fas fa-check text-primary mr-2"></i>Kho bãi an toàn</li>
                        <li class="flex items-center"><i class="fas fa-check text-primary mr-2"></i>Bảo hiểm 24/7</li>
                        <li class="flex items-center"><i class="fas fa-check text-primary mr-2"></i>Giá cả hợp lý</li>
                    </ul>
                </div>

                <!-- Service 6 -->
                <div class="bg-card p-8 rounded-xl shadow-sm border border-border hover:shadow-md transition-shadow">
                    <div class="w-16 h-16 bg-primary/10 rounded-lg flex items-center justify-center mb-6">
                        <i class="fas fa-tools text-primary text-2xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold text-card-foreground mb-4">Lắp Đặt & Sửa Chữa</h3>
                    <p class="text-muted-foreground mb-6">
                        Dịch vụ lắp đặt và sửa chữa đồ nội thất sau khi chuyển nhà.
                    </p>
                    <ul class="space-y-2 text-sm text-muted-foreground">
                        <li class="flex items-center"><i class="fas fa-check text-primary mr-2"></i>Thợ chuyên nghiệp</li>
                        <li class="flex items-center"><i class="fas fa-check text-primary mr-2"></i>Dụng cụ đầy đủ</li>
                        <li class="flex items-center"><i class="fas fa-check text-primary mr-2"></i>Bảo hành dịch vụ</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <!-- Why Choose Us Section -->
    <section class="py-16 bg-muted/30">
        <div class="container mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-12">
                <h2 class="text-3xl md:text-4xl font-bold text-foreground mb-4">Tại Sao Chọn MoveEasy?</h2>
                <p class="text-xl text-muted-foreground max-w-2xl mx-auto">
                    Chúng tôi cam kết mang đến dịch vụ chuyển nhà tốt nhất với những ưu điểm vượt trội
                </p>
            </div>

            <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-8">
                <div class="text-center">
                    <div class="w-20 h-20 bg-primary/10 rounded-full flex items-center justify-center mx-auto mb-4">
                        <i class="fas fa-shield-alt text-primary text-3xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold text-foreground mb-2">An Toàn Tuyệt Đối</h3>
                    <p class="text-muted-foreground">Bảo hiểm toàn diện và quy trình an toàn nghiêm ngặt</p>
                </div>

                <div class="text-center">
                    <div class="w-20 h-20 bg-primary/10 rounded-full flex items-center justify-center mx-auto mb-4">
                        <i class="fas fa-clock text-primary text-3xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold text-foreground mb-2">Nhanh Chóng</h3>
                    <p class="text-muted-foreground">Hoàn thành trong thời gian cam kết, không làm phiền khách hàng</p>
                </div>

                <div class="text-center">
                    <div class="w-20 h-20 bg-primary/10 rounded-full flex items-center justify-center mx-auto mb-4">
                        <i class="fas fa-dollar-sign text-primary text-3xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold text-foreground mb-2">Giá Cả Hợp Lý</h3>
                    <p class="text-muted-foreground">Báo giá minh bạch, không phát sinh chi phí ẩn</p>
                </div>

                <div class="text-center">
                    <div class="w-20 h-20 bg-primary/10 rounded-full flex items-center justify-center mx-auto mb-4">
                        <i class="fas fa-users text-primary text-3xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold text-foreground mb-2">Đội Ngũ Chuyên Nghiệp</h3>
                    <p class="text-muted-foreground">Nhân viên được đào tạo bài bản, kinh nghiệm lâu năm</p>
                </div>
            </div>
        </div>
    </section>

    </section>

    <%-- =================================================================== --%>
    <%-- BẮT ĐẦU: DÁN KHU VỰC REVIEW MỚI CỦA BẠN VÀO ĐÂY --%>
    <%-- =================================================================== --%>

    <section class="py-16">
        <div class="container mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-12">
                <h2 class="text-3xl md:text-4xl font-bold text-gray-800 mb-4">Khách Hàng Nói Gì Về Chúng Tôi</h2>
                <p class="text-xl text-gray-600 max-w-2xl mx-auto">
                    Những đánh giá chân thực từ những khách hàng đã tin tưởng sử dụng dịch vụ của MoveEasy.
                </p>
            </div>

            <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
                <div class="bg-white p-8 rounded-xl shadow-sm border border-gray-200 flex flex-col">
                    <div class="flex-grow mb-6">
                        <div class="flex items-center mb-4 text-yellow-400">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <p class="text-gray-600 italic">"Dịch vụ quá tuyệt vời! Đội ngũ nhân viên rất nhiệt tình và chuyên nghiệp. Đồ đạc của tôi được bảo vệ cẩn thận và không hề có trầy xước. Sẽ giới thiệu cho bạn bè!"</p>
                    </div>
                    <div class="flex items-center mt-auto">
                        <img class="w-12 h-12 rounded-full mr-4 object-cover"
                             src="${pageContext.request.contextPath}/assets/images/user/1.jpg"
                             alt="Avatar của Anh Trần Văn Minh">
                        <div>
                            <h4 class="font-semibold text-gray-900">Anh Trần Văn Minh</h4>
                            <p class="text-gray-500 text-sm">Khách hàng</p>
                        </div>
                    </div>
                </div>

                <div class="bg-white p-8 rounded-xl shadow-sm border border-gray-200 flex flex-col">
                    <div class="flex-grow mb-6">
                        <div class="flex items-center mb-4 text-yellow-400">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <p class="text-gray-600 italic">"Tôi rất hài lòng với MoveEasy. Mọi thứ diễn ra nhanh chóng, đúng giờ và giá cả rất hợp lý. Các bạn nhân viên rất khỏe và cẩn thận."</p>
                    </div>
                    <div class="flex items-center mt-auto">
                        <img class="w-12 h-12 rounded-full mr-4 object-cover"
                             src="${pageContext.request.contextPath}/assets/images/user/2.jpg"
                             alt="Avatar của Chị Lê Thị Hoa">
                        <div>
                            <h4 class="font-semibold text-gray-900">Chị Lê Thị Hoa</h4>
                            <p class="text-gray-500 text-sm">Khách hàng</p>
                        </div>
                    </div>
                </div>

                <div class="bg-white p-8 rounded-xl shadow-sm border border-gray-200 flex flex-col">
                    <div class="flex-grow mb-6">
                        <div class="flex items-center mb-4 text-yellow-400">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="far fa-star"></i> </div>
                        <p class="text-gray-600 italic">"Dịch vụ tốt, tuy nhiên lúc đến hơi trễ so với lịch hẹn 15 phút. Dù vậy, các bạn đã làm việc rất nhanh để bù lại thời gian. Nói chung là ổn!"</p>
                    </div>
                    <div class="flex items-center mt-auto">
                        <img class="w-12 h-12 rounded-full mr-4 object-cover"
                             src="${pageContext.request.contextPath}/assets/images/user/3.jpg"
                             alt="Avatar của Anh Phạm Đức Thắng">
                        <div>
                            <h4 class="font-semibold text-gray-900">Anh Phạm Đức Thắng</h4>
                            <p class="text-gray-500 text-sm">Khách hàng</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <%-- =================================================================== --%>
    <%-- KẾT THÚC KHU VỰC REVIEW --%>
    <%-- =================================================================== --%>

    <section class="py-16">

    <!-- CTA Section -->
    <section class="py-16">
        <div class="container mx-auto px-4 sm:px-6 lg:px-8">
            <div class="bg-primary rounded-2xl p-8 md:p-12 text-center text-primary-foreground">
                <h2 class="text-3xl md:text-4xl font-bold mb-4">Sẵn Sàng Chuyển Nhà?</h2>
                <p class="text-xl mb-8 opacity-90">
                    Liên hệ ngay để được tư vấn miễn phí và báo giá chi tiết
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="booking.html" class="bg-background text-foreground hover:bg-background/90 px-8 py-4 rounded-lg font-semibold text-lg transition-colors inline-flex items-center justify-center">
                        <i class="fas fa-phone mr-2"></i>
                        Đặt Lịch Ngay
                    </a>
                    <a href="tel:1900123456" class="bg-primary-foreground/20 hover:bg-primary-foreground/30 text-primary-foreground border border-primary-foreground/30 px-8 py-4 rounded-lg font-semibold text-lg transition-colors inline-flex items-center justify-center">
                        <i class="fas fa-phone-alt mr-2"></i>
                        1900 123 456
                    </a>
                </div>
            </div>
        </div>
    </section>

    <script>
        // Smooth scrolling for navigation links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    </script>
</body>
</html>