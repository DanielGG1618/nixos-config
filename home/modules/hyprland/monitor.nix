let 
  laptop-w = 3120;
  laptop-h = 2080;
  # laptop-h-cm = 20;
  laptop-res = "${toString laptop-w}x${toString laptop-h}";

  laptop-virt-h = 1300.0;
  laptop-scale = laptop-h / laptop-virt-h;
  laptop-scale-str = toString laptop-scale;

  monitor-offset-y-cm = 21.4;
  monitor-w = 1920;
  monitor-h = 1080;
  monitor-h-cm = 30;
  monitor-res = "${toString monitor-w}x${toString monitor-h}";

  monitor-virt-h = 1440.0;
  monitor-scale = monitor-h / monitor-virt-h;
  monitor-scale-str = toString monitor-scale;

  monitor-virt-w = monitor-w / monitor-scale; 
  monitor-virt-offset-y = monitor-virt-h * monitor-offset-y-cm / monitor-h-cm;
  monitor-pos = "-${toString monitor-virt-w}x-${toString monitor-virt-offset-y}";
in [
  "eDP-1, ${laptop-res}, 0x0, ${laptop-scale-str}"
  ", ${monitor-res}, ${monitor-pos}, ${monitor-scale-str}"
]