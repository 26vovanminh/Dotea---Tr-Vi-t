CREATE DATABASE IF NOT EXISTS `dotea`
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE `dotea`;

-- 1. Bảng khách hàng
CREATE TABLE IF NOT EXISTS `khach_hang` (
  `khach_hang_id` INT AUTO_INCREMENT PRIMARY KEY,
  `ho_ten` VARCHAR(100) NOT NULL,
  `so_dien_thoai` VARCHAR(15) NOT NULL,
  `dia_chi` VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- 2. Bảng sản phẩm
CREATE TABLE IF NOT EXISTS `san_pham` (
  `san_pham_id` INT AUTO_INCREMENT PRIMARY KEY,
  `ten_san_pham` VARCHAR(150) NOT NULL,
  `gia` INT NOT NULL,
  `hinh_anh` VARCHAR(255) NOT NULL,
  `mo_ta` TEXT,
  `noi_bat` TINYINT(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- 3. Bảng đơn hàng
CREATE TABLE IF NOT EXISTS `don_hang` (
  `don_hang_id` INT AUTO_INCREMENT PRIMARY KEY,
  `ma_don_hang` VARCHAR(20) NOT NULL UNIQUE,
  `khach_hang_id` INT NOT NULL,
  `tong_tien` INT NOT NULL,
  `ghi_chu` TEXT,
  `trang_thai` VARCHAR(50) DEFAULT 'Chờ xác nhận',
  `ngay_dat` DATETIME DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT `fk_don_hang_khach_hang`
    FOREIGN KEY (`khach_hang_id`)
    REFERENCES `khach_hang`(`khach_hang_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- 4. Bảng chi tiết đơn hàng
CREATE TABLE IF NOT EXISTS `chi_tiet_don_hang` (
  `chi_tiet_id` INT AUTO_INCREMENT PRIMARY KEY,
  `don_hang_id` INT NOT NULL,
  `san_pham_id` INT NOT NULL,
  `so_luong` INT NOT NULL,
  `don_gia` INT NOT NULL,
  `thanh_tien` INT NOT NULL,

  CONSTRAINT `fk_chi_tiet_don_hang`
    FOREIGN KEY (`don_hang_id`)
    REFERENCES `don_hang`(`don_hang_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  CONSTRAINT `fk_chi_tiet_san_pham`
    FOREIGN KEY (`san_pham_id`)
    REFERENCES `san_pham`(`san_pham_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Dữ liệu mẫu khách hàng (đã bỏ email và mật khẩu)
INSERT INTO `khach_hang`
(`khach_hang_id`, `ho_ten`, `so_dien_thoai`, `dia_chi`)
VALUES
(1, 'Nguyễn Văn An', '0912345678', 'Số 12 Chùa Láng, Đống Đa, Hà Nội'),
(2, 'Trần Thị Mai', '0987654321', 'Số 79 Hồ Tùng Mậu, Cầu Giấy, Hà Nội'),
(3, 'Lê Hoàng Nam', '0905123456', 'Số 45 Xuân Thủy, Cầu Giấy, Hà Nội');


-- Dữ liệu mẫu sản phẩm (đã bỏ khóa ngoại đến bảng danh_muc)
INSERT INTO `san_pham`
(`san_pham_id`, `ten_san_pham`, `gia`, `hinh_anh`, `mo_ta`, `noi_bat`)
VALUES
(1, 'Trà đen', 61000, 'images/traden.jpg',
 'Trà đen Dootea mang hương vị đậm đà, hương thơm tự nhiên và hậu vị dễ chịu.', 0),

(2, 'Trà nhài', 65000, 'images/tranhai.jpg',
 'Trà nhài Dootea kết hợp vị trà thanh nhẹ cùng hương hoa nhài tự nhiên.', 1),

(3, 'Trà ô long', 70000, 'images/traolong.jpg',
'Trà ô long Dootea có hương thơm đặc trưng, vị trà thanh dịu và hậu vị nhẹ nhàng.', 0),

(4, 'Trà sen', 75000, 'images/trasen.jpg',
 'Trà sen Dootea mang hương sen thanh tao, dịu nhẹ và phù hợp cho những phút thư giãn.', 1),

(5, 'Trà xanh', 60000, 'images/traxanh.jpg',
 'Trà xanh Dootea có hương thơm tự nhiên, vị thanh nhẹ và tươi mát.', 0);


-- Dữ liệu mẫu đơn hàng
INSERT INTO `don_hang`
(`don_hang_id`, `ma_don_hang`, `khach_hang_id`, `tong_tien`, `ghi_chu`, `trang_thai`)
VALUES
(1, 'DT284910', 1, 136000, 'Giao giờ hành chính', 'Chờ xác nhận'),
(2, 'DT719245', 2, 150000, 'Gọi trước khi giao', 'Đang giao'),
(3, 'DT532189', 3, 70000, 'Để ở quầy lễ tân', 'Đã giao');


-- Dữ liệu mẫu chi tiết đơn hàng
INSERT INTO `chi_tiet_don_hang`
(`chi_tiet_id`, `don_hang_id`, `san_pham_id`, `so_luong`, `don_gia`, `thanh_tien`)
VALUES
(1, 1, 1, 1, 61000, 61000),
(2, 1, 4, 1, 75000, 75000),
(3, 2, 4, 2, 75000, 150000),
(4, 3, 3, 1, 70000, 70000);