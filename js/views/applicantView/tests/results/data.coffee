module.exports = exports =
  E:
    count: 11
    description: 'درون‌گرایی به طور عمده جهت‌گیری انرژی به سمت دنیای درون، تجربه‌ها و عقیده‌ها است. از جمله خصوصیات مرتبط با درون‌گرایی عبارتند از این که از تنها بودن انرژی می‌گیرند. نمی‌خواهند کانون توجه باشند. موضوعات را در ذهن خود ارزیابی می‌کنند. اطلاعات شخصی را کمتر بروز می‌دهند. بیش از آن که حرف بزنند، گوش می‌دهند. در روابط عمق و کیفیت را بر گستردگی ترجیه می‌دهند.'

  ENFJ:
    0: 'هدف‌گذار - با اراده - مهارت کلامی - رهبر داتی - سنتی و محافظه کار - سریع - غیر قابل انطاف - خودجوش'
    1: [
      'واقع‌بین، اهل عمل و کم احساس است.'
      'در زمینه تجارت و کارهای فنی استعداد خاصی از خود نشان می‌دهد.'
      'در مورد موضوعاتی که نیاز به آنها احساس نمی‌شود بی‌علاقگی نشان می‌دهد ولی در صورت لزوم آن را بکار می‌برد.'
      'معمولا کارها را به خوبی انجام می‌دهد، به خصوص اگر هنگام اتخاذ تصمیم، احساسات و نقطه نظرهای متفاوت را در نظر بگیرد.'
      'علاقه زیادی به سازماندهی و هدایت فعالییتها و پروژه‌ها دارد.'
    ]
    2: [
      'توجه به نتایج'
      'توجه جدی به تعهدات'
      'توجه به اهداف سازمانی'
      'داشتن توجه و دقت و میل به درست انجام دادن کارها'
      'میل به تبعیت از رویه‌ها و مقررات روزمره'
      'توانایی تشخیص اقدامات غیر منطقی و ناکارآمد'
      'مهارت‌های سازمانی، توانایی در تصمیم‌گیریهای عینی و منطقی'
      'اعتقاد به ارزش ساختار سنتی و توانایی کار کردن در محدوده آن'
      'داشتن احساس مسئولیت، می‌توان روی حرف شما حساب کرد'
      'داشتن اخلاق کاری روشن، نیاز به کارآیی و کارآمدی'
      'عقل سلیم و چشم اندازهای واقع‌بینانه'
    ]
    3: [
      'ناشکیبایی با کسانی که مطابق رویه‌ها و مقررات کار نمی‌کنند و یا جزئیات را نادیده می‌گیرند'
      'بی‌میلی در استفاده از نقطه نظرات جدید و آزمون نشده'
      'داشتن مقاومت در برابر تغییر'
      'تحمل نکردن عدم کارآیی و یا فرایند‌های وقت‌گیر'
      'توجه به نیازهای موجود و بی‌توجهی به نیازهای آینده'
      'تمایل به نادیده انگاشتن اشخاص برای دستیابی به هدف خود'
      'ناتوانی در دیدن امکانات و احتمالات آتی'
      'نداشتن این حساسیت که دیگران چگونه تحت تاثیر سیاستها و تصمیمات شما قرار می‌گیرند'
      'دشواری در گوش دادن به نظرات مخالف، ممکن است بارها سخن دیگران را قطع کند'
    ]
    4: [
      'مامور بیمه'
      'تحلیل‌گر بودجه'
      'حسابرس'
      'تحلیل‌گر اعتبارات'
      'افسر انتظامی'
      'مدیر کارخانه'
      'مهندس صنعتی'
      'دندانپزشک'
      'مسئول ایمنی'
    ]
    5: [
      'از تصمیم‌گیریهای بیش از اندازه سریع خودداری کنید'
      'از روش‌های مبتکرانه و غیر متعارف در یافتن شغل خودداری کنید'
      'از توصیه‌های همکارانتان استفاده کنید'
      'از توانمندیها و نقاط قوت خود استفاده کنید'
      'کارهایی را پیدا کنید و داوطلبانه سرپرستی کنید'
      'همکاران کارآمدی پیدا کنید'
    ]

['I', 'N', 'S', 'F', 'T', 'J', 'P'].forEach (x) -> exports[x] = exports.E
['INFJ', 'ESFJ', 'ENTJ', 'ENFP', 'ISFJ', 'INTJ', 'INFP', 'ESTJ', 'ESFP', 'ENTP', 'ISTJ', 'ISFP', 'INTP', 'ESTP', 'ISTP'].forEach (x) -> exports[x] = exports.ENFJ
