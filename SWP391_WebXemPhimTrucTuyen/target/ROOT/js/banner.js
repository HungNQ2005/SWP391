// Mảng ảnh banner
const banners = [
  {
    image: "https://img.pikbest.com/origin/10/00/55/34mpIkbEsTI9M.jpg!w700wp",
  },
  {
    image:
      "https://www.sonqb.com/media/2021/07/thiet-ke-banner-quang-cao-dep-chuyen-nghiep-6934.jpg",
  },
  {
    image:
      "https://thudaumot.edu.vn/wp-content/uploads/2021/04/Banner-quang-cao-may-tinh-3.jpg",
  },
  {
    image:
      "https://honda-mydinh.com.vn/wp-content/uploads/2018/11/01-banner-Honda-hr-v-2018-ra-mat-tai-viet-nam-1.jpg",
  },
];

let current = 0;

const banner = document.getElementById("banner");

function updateBanner() {
  banner.style.backgroundImage = `url('${banners[current].image}')`;
  current = (current + 1) % banners.length;
}

updateBanner();
setInterval(updateBanner, 5000);
