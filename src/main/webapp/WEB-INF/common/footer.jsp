<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Footer Fragment for JSP -->
<footer class="bg-card border-t border-border py-12">
    <div class="container mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
            <div>
                <div class="flex items-center space-x-2 mb-4">
                    <div class="w-8 h-8 bg-primary rounded-lg flex items-center justify-center">
                        <i class="fas fa-truck text-primary-foreground"></i>
                    </div>
                    <span class="text-2xl font-bold text-primary">${companyName != null ? companyName : 'MoveEasy'}</span>
                </div>
                <p class="text-muted-foreground mb-4">
                    Dịch vụ chuyển nhà chuyên nghiệp, an toàn và tiết kiệm. Chúng tôi cam kết mang đến trải nghiệm tốt nhất cho khách hàng.
                </p>
                <div class="flex space-x-4">
                    <a href="#" class="text-muted-foreground hover:text-primary transition-colors">
                        <i class="fab fa-facebook text-xl"></i>
                    </a>
                    <a href="#" class="text-muted-foreground hover:text-primary transition-colors">
                        <i class="fab fa-twitter text-xl"></i>
                    </a>
                    <a href="#" class="text-muted-foreground hover:text-primary transition-colors">
                        <i class="fab fa-instagram text-xl"></i>
                    </a>
                    <a href="#" class="text-muted-foreground hover:text-primary transition-colors">
                        <i class="fab fa-youtube text-xl"></i>
                    </a>
                </div>
            </div>
            
            <div>
                <h4 class="font-semibold text-card-foreground mb-4">Dịch Vụ</h4>
                <ul class="space-y-2">
                    <li><a href="#" class="text-muted-foreground hover:text-primary transition-colors">Chuyển Nhà Cơ Bản</a></li>
                    <li><a href="#" class="text-muted-foreground hover:text-primary transition-colors">Chuyển Nhà Tiêu Chuẩn</a></li>
                    <li><a href="#" class="text-muted-foreground hover:text-primary transition-colors">Chuyển Nhà Cao Cấp</a></li>
                    <li><a href="#" class="text-muted-foreground hover:text-primary transition-colors">Đóng Gói Đồ Đạc</a></li>
                    <li><a href="#" class="text-muted-foreground hover:text-primary transition-colors">Lưu Kho Tạm Thời</a></li>
                </ul>
            </div>
            
            <div>
                <h4 class="font-semibold text-card-foreground mb-4">Công Ty</h4>
                <ul class="space-y-2">
                    <li><a href="#" class="text-muted-foreground hover:text-primary transition-colors">Giới Thiệu</a></li>
                    <li><a href="#" class="text-muted-foreground hover:text-primary transition-colors">Tin Tức</a></li>
                    <li><a href="#" class="text-muted-foreground hover:text-primary transition-colors">Tuyển Dụng</a></li>
                    <li><a href="#" class="text-muted-foreground hover:text-primary transition-colors">Liên Hệ</a></li>
                    <li><a href="#" class="text-muted-foreground hover:text-primary transition-colors">Đối Tác</a></li>
                </ul>
            </div>
            
            <div>
                <h4 class="font-semibold text-card-foreground mb-4">Hỗ Trợ</h4>
                <ul class="space-y-2">
                    <li><a href="#" class="text-muted-foreground hover:text-primary transition-colors">Trung Tâm Trợ Giúp</a></li>
                    <li><a href="#" class="text-muted-foreground hover:text-primary transition-colors">Hướng Dẫn Sử Dụng</a></li>
                    <li><a href="#" class="text-muted-foreground hover:text-primary transition-colors">Trạng Thái Dịch Vụ</a></li>
                    <li><a href="#" class="text-muted-foreground hover:text-primary transition-colors">Cộng Đồng</a></li>
                    <li><a href="#" class="text-muted-foreground hover:text-primary transition-colors">Báo Cáo Sự Cố</a></li>
                </ul>
            </div>
        </div>
        
        <div class="border-t border-border mt-8 pt-8">
            <div class="flex flex-col md:flex-row justify-between items-center">
                <p class="text-muted-foreground text-center md:text-left">
                    © 2025 ${companyName != null ? companyName : 'MoveEasy'}. Tất cả quyền được bảo lưu.
                </p>
                <div class="flex space-x-6 mt-4 md:mt-0">
                    <a href="#" class="text-muted-foreground hover:text-primary transition-colors text-sm">Điều Khoản Sử Dụng</a>
                    <a href="#" class="text-muted-foreground hover:text-primary transition-colors text-sm">Chính Sách Bảo Mật</a>
                    <a href="#" class="text-muted-foreground hover:text-primary transition-colors text-sm">Cookie Policy</a>
                </div>
            </div>
        </div>
    </div>
</footer>