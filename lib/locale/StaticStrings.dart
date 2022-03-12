import 'package:get/get.dart';
import 'package:flutter/material.dart';
class Language extends GetxController{
  static change(var param1, var param2){
    Get.updateLocale(Locale(param1, param2));
  }
}
class StaticStrings extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {

    "ar": ar,
  };

  final Map<String, String> ar = {"New password": "كلمة المرور الجديدة",


    "Ok": "انهاء",
    "Final Bill via wallet": "الفاتورة النهائية عبر المحفظة",
    "Accept & Pay by Wallet": "قبول والدفع عن طريق المحفظة",
    "Pay from wallet": "الدفع من المحفظة",
    "You have Cashback of: ": "لديك استرداد نقدي بقيمة:",
    "Cashback": "استرداد النقود",
    "Sending offers": "ارسال العروض",
    "This service will be available soon"
        "\nWe are testing the technician to make the best check car service for you"
        "\nYou can call us directly to take a free consultation at 0507888779":
  "\nستتوفر قريباً هذه الخدمة"
"\nنختبر حالياً الفنيين لتقديم افضل خدمة فحص لكم "
 "  يمكنكم الاتصال مباشرة لتقديم استشارة مجانية على الرقم  0507888779"

  ,"Technician service": "خدمة الفني الزائر",
    "This service will be available so soon.\n"
        "We are collecting the best car pickups for you, please keep in touch.": "ستتوفر قريباً هذه الخدمة نختبر حالياً السطحات لتقديم افضل خدمة لنقل سيارتك",
    "Pickup service": "خدمة السطحة",
    "Congratulations 🎉, your car is fixed, please get your car and check it before you leave.": "مبروك 🎉، تم إصلاح سيارتك، فضلاً توجه الى الورشة لتجربة السيارة واستلامها",
    "Deal, now you can relax and wait till the workshop complete fixing.": "تم الاتفاق ✅، الآن يمكنك الاسترخاء حتى تنتهي الورشة من إصلاح سيارتك",
    "Please go to the workshop and let him check your can to confirm the deal": "فضلاً توجه الى الورشة ليتم فحص السيارة والاتفاق",
    "We are looking for the best workshops offer for you, please wait": "جاري البحث عن أفضل العروض المناسبة لك، فضلاً انتظر قليلاً",
    "Average Price": "متوسط السعر",
    "Working days": "يوم عمل",
    "I Need Help": "لا أدري، أحتاج مساعدة مُصان",
    "Pick My Car": "أحتاج لسطحة لنقل السيارة",
    "Check My Car": "أحتاج فني لفحص عطل السيارة",
    "Fix My Car": "أحتاج صيانة عطل بالسيارة",
    "Call Workshop": "اتصال مباشر",
    "Chat Room": "غرفة الدردشة",
    "Please select service you need.": "فضلاً اختر الخدمة التي تحتاجها.",
    "How can I help you?": "كيف يمكنني مساعدتك؟",
    "Welcome!": "أهلاً وسهلاً",
    "Order Part": "طلب جزء",
    "Car Details": "تفاصيل السيارة",
    "Car model name": "طراز السيارة",
    "you have to add a comment to let the workshop catch your issue easily.": "يجب عليك إضافة تعليق للسماح للورشة بالتعرف على مشكلتك بسهولة.",
    "Cancel": "يلغي",
    "Photo Roll": "لفة الصور",
    "Open Camera": "افتح الكاميرا",
    "Write a note": "اكتب ملاحظة",
    "Please upload photos of your issue to help workshops": "يرجى تحميل صور مشكلتك للمساعدة في ورش العمل",
    "Upload photos": "تحميل الصور",
    "Upload some photos & leave a note if you want": "قم بتحميل بعض الصور واترك ملاحظة إذا كنت تريد ذلك",
    "Additional information": "معلومة اضافية",
    "Step 4 of 4": "الخطوة 4 من 4",
    "Add new car": "أضف سيارة جديدة",
    "Select one of your car or add new one": "فضلاً اختر سياراتك أو أضف سيارة جديدة",
    "Step 3 of 4": "الخطوة 3 من 4",
    "You can select multiple options": "يمكنك تحديد خيارات متعددة",
    "Search for place": "ابحث عن مكان",
    "Please enter your car location on the map": "الرجاء إدخال موقع سيارتك على الخريطة",
    "Car Location": "موقع السيارة",
    "Step 1 of 4": "الخطوة 1 من 4",
    "Send an offer": "أرسل عرض",
    "Notifications": "الإشعارات",
    "please_enter_valid_email_address": "الرجاء ادخال بريد الكتروني صحيح",
    "the_password_must_be_identical": "يجب ان يكون الرقم السري متطابق",
    "the_password_must_be_7_characters_or_more": "يجب ان يكون الرقم السري 7 أحرف أو أكثر",
    "please_enter_your_full_name": "الرجاء ادخال الاسم كاملا",
    "please_wait": "الرجاء الانتظار..",

    "Message is missing": "الرسالة غير موجودة",
    "Title is missing": "العنوان غير موجود",
    "Phone Number": "رقم الجوال",
    "please_enter_correct_phone_number": "الرجاء إدخال رقم الجوال الصحيح",
    "Email": "البريد الإلكتروني",
    "Process": "تحت الإجراء",
    "successful":"عملية ناجحة",
    "Name":"الاسم",
    "Value":"قيمة",
    "Something went wrong while creating user":"ظهرت مشكلة أثناء إنشاء الحساب",
    "pictures":"صور",
    "Phone":"جوال",
    "Display Picture":"ظهور الصورة",
    "Estimated price":"السعر المتوقع",
    "Card Added":"تم اضافة البطاقة",
    "Press again to Exit":"إضغط مرة أخرى لتسجيل الخروج",
    "Invite Selection":"تحديد الدعوة",
    "Please select Provider or client":"فضلاً إختر مزود خدمة أو عميل",
    "Topic Un-Subscribed":"عنوان غير مشترك",
    "Topic Subscribed":"عنوان مشترك",
    "Others":"أخرى",
    "Credit/debit card":"بطاقة مسبقة الدفع/ مباشر",
    "Mada":"مدى",
    "Expiry Date MM-YY":"تاريخ الانتهاء MM-YY",
    "Invalid Card Details":"بيانات البطاقة غير صحيحة",
    "ADD":"إضافة",
    "Payment":"المحفظة",
    "Wallet":"المحفظة",
    "Please Select a card first":"فضلاً إختر البطاقة أولاً",
    "Add a new payment method":"أضف طريقة دفع جديدة",
    "CAR PICK UP":"سطحة",
    "DownPayment":"دفعة مقدمة",
    "called":"تم الاتصال",
    "free comment is missing":"لم يتم كتابة توضيح المشكلة (تعليق)",
    "Incomplete information":"البيانات ليست كاملة",
    "Please find and correct which is missing":"فضلاً استكمل الخانات المتبقية",
    "Incomplete":"لم يكتمل",
    "Please Select all Information":"فضلاً حدد جميع البيانات",
    "Gear transmission":"نوع الجير",
    "auto ":"أوتوماتيك",
    "Auto ":"أوتوماتيك",
    "Auto":"أوتوماتيك",
    "manual":"عادي",
    "Manual":"عادي",
    "Model":"سنة الصنع",
    "Color":"اللون",
    "Company":"الشركة",
    "Select a car":"اختر السيارة",
    "Address":"العنوان",
    "Continue with Google email":"الاستمرار عن طريق جوجل",
    "Log in":"تسجيل الدخول",
    "Failed":"حدث خطأ",
    "verificationFailed":"حدث خطأ بالتفعيل",
    "Alert":"تنبيه",
    "Log out":"تسجيل خروج",
    "Do you want to change app language to":"هل تريد تغيير لغة التطبيق إلى",
    "Auto retrieval time out":"انتهت مدة التفعيل",
    "Create an Account":"أنشئ حساب جديد",
    "No Address Associated":"لم يتم ادخال العنوان",
    "General Information":"معلومات عامة",
    "both fields are compulsory":"كلا الخانتين إلزامية",
    "Missing":"لم يتم العثور عليه",
    "Call us":"إتصل بنا",
    "Support":"الدعم",
    "Help for orders":"مساعدة على الطلبات",
    "Help for wallet":"مساعدة على المحفظة",
    "Contact us Via":"تواصل معنا",
    "SMS":"رسالة جوال",
    "workshops":"الورش",
    "Technicians":"الفنيين",
    "transport vehicles":"سطحات",
    "Order From Report":"أطلب بالتقرير",
    "Your location":"موقعك",
    "Report":"تقرير",
    "Issue type":"نوع المشكلة",
    "Comment":"العطل",
    "You can now order our pickup service to help you bring your car to the workshop":"تستطيع الآن طلب سطحة لنقل سيارتك من مكانك إلى مركز الصيانة المحدد.",
    "Need a car pickup?":"هل تحتاج سطحة لنقل سيارتك؟",
    "Do you know what's the issue?":"هل تعرف عطل السيارة؟",
    "No":"لا",
    "No Car Available":"لم يتم اضافة سيارة حتى الآن",
    "No Order Yet":"لا يوجد طلبات حالية",
    "Pay Car Pick up Bill":"دفع فاتورة استلام السيارة",
    "Yes":"نعم",
    "Call engineer":"إتصل بالمهندس",
    "Report List":"قائمة التقارير",
    "Car Type":"نوع السيارة ",
    "Date":"التاريخ",
    "Issue Types":"أنواع الأعطال",
    "Order":"طلب",
    "Technician tracking":"متابعة الفني",
    "Workshop order":"طلب الورشة",
    "Technician order":"طلب فني",
    "What's your car":"ما هي سيارتك؟",
    "Add a new car":"أضف سيارة جديدة",
    "Attach\n Picture":"إرفق صورة",
    "Issue name":"اسم المشكلة",
    "Photo Library":"صور الألبوم",
    "Camera":"كاميرا",
    "Add a car":"أضف سيارة جديدة",
    "Company name":"اسم الشركة",
    "Order History":"تاريخ الطلب",
    "Reports":"التقارير",
    "See Order Details":"عرض تفاصيل الطلب",
    "SR":"ر.س",
    "SR ": " ر.س ",
    "Musan fee":"رسوم مصان",
    "fee":"رسوم",
    "Work cost":"تكلفة الإصلاح",
    "Offers":"العروض",
    "Technician":"فني",
    "order date":"تاريخ الطلب",
    "Order date":"تاريخ الطلب",
    "Car":"السيارة",
    "Issues":"أعطال",
    "Total cost":"التكلفة الإجمالية",
    "workshop offer":"عروض الورش",
    "Order tracking":"متابعة الطلب",
    "Order No":"رقم الطلب",
    "Order number":"رقم الطلب",
    "WorkShop Location":"موقع الورشة",
    "Track on Map":"تتبع بالخريطة",
    "Completed":"اكتمل",
    "Step 4":"الإصلاح والصيانة",
    "Step 5":"التجربة والتسليم",
    "Accepted":"معتمدة",
    "Waiting Approval":"في انتظار الإعتماد",
    "Rejected":"مرفوض",
    "Down Payment Received":"تم استلام الدفعة المقدمة",
    "Client has paid by credit to Musan, Please Wait for 10 minutes to transfer the amount to you":"قام العميل بالدفع عن طريق البطاقة لمصان، يرجى الانتظار لمدة 10 دقائق لتحويل المبلغ إليك",
    "PDF":"عرض",
    "VAT":"ضريبة القيمة المضافة",
    "Timing":"المدة",
    "Days":"يوم",
    "Chat":"محادثة",
    "Call":"إتصال",
    "call now and talk to our representative":"اتصل الآن وتحدث إلى خدمة العملاء",
    "Order car pickup":"طلب سطحة",
    "See Pending Approvals":"عرض الاعتمادات المعلقة",
    "Calling at":"جاري الإتصال",
    "Cancel order":"إلغاء الطلب",
    "Cancel Order":"إلغاء الطلب",
    "Are you sure you want to\ncancel this order?":"هل أنت متأكد من إلغاء الطلب؟",
    "in process":"تحت الإجراء",
    "Pay down payment":"دفع دفعة مقدمة",
    "you are requested to pay down payment before staring work!":"تم طلب دفع دفعة مقدمة قبل البدء في الإصلاح",
    "Pay SAR ":"دفع بالريال السعودي",
    "Time and cost changes":"تغيير المدة والتكلفة",
    "Work Price":"تكلفة الإصلاح",
    "Reject":"رفض",
    "Accept & pay later":"قبول والدفع لاحقًا",
    "Add an invoice":"إضافة فاتورة",
    "Accept & Pay":"قبول ودفع",
    "Accept & Request to postpone the payment":"قبول وطلب تأجيل الدفع",
    "Pay Final Bill":"دفع الفاتورة النهائية",
    "Pay":"دفع",
    "(Type of payment here-Final/Part/Other)":"نظام الدفع",
    "Order details":"تفاصيل الطلب",
    "Attachments":"المرفقات",
    "Issue":"العطل",
    "Cost":"التكلفة",
    "Invoices":"الفواتير",
    "Invoices Details":"تفاصيل الفاتورة",
    "Offers List":"قائمة العروض",
    "Average Price":"متوسط التكلفة",
    "Average Time":"متوسط المدة",
    "Warranty":"الضمان",
    "Verified by Musan":"معتمد من مصان",
    "Negotiate":"تفاوض",
    "Accept":"قبول",
    "Negotiation":"التفاوض",
    "Set price":"اكتب سعر",
    "Cancel":"إلغاء",
    "dd-MM-yyyy":"dd-MM-yyyy",
    "My Cars":"سياراتي",
    "Help":"مساعدة",
    "Time":"مدة",
    "Mark as read":"تحديد كمقروء",
    "EditProfile":"تعديل الملف الشخصي",
    "Upload a new photo":"إضافة صورة جديدة",
    "Please compelete the forms":"فضلاً أكمل النموذج",
    "Save changes":"حفظ التغييرات",
    "Provider":"مزود خدمة",
    "Invite":"دعوة صديق",
    "Payment Method":"طريقة الدفع",
    "Payments History":"تاريخ المدفوعات",
    "Spent":"المصروف",
    "Pending":"المتبقي",
    "Car name":"إسم السيارة",
    "FinalBill":"الفاتورة النهائية",
    "Pay now":"الدفع الآن",
    "Amount":"القيمة",
    "Date & Time":"تاريخ ومدة ",
    "View description":"إظهار الوصف",
    "Already default payment method":"طريقة الدفع الافتراضية",
    "setting default payment method":"تحديد طريقة الدفع الافتراضية",
    "your order is placed":"تم دفع طلبك",
    "Privacy":"الخصوصية",
    "Confirm Address":"تأكيد العنوان",
    ""
        " and conditions":"الشروط والأحكام",
    "About us":"عن التطبيق",
    "Enter Some Text":"أدخل بعض النص",
    "Send Message":"أرسل رسالة",
    "MusanClient":"عميل مصان",
    "Incorrect username / password":"اسم المستخدم / كلمة المرور غير صحيحة",
    "You're not allowed to login":"لا يسمح لك بتسجيل الدخول",
    "Offer sent":"تم إرسال العرض",
    "Do you want to save order operations?":"هل تريد حفظ عمليات الطلب؟",
    "Save operations":"حفظ العمليات",
    "Your comment about the order":"تعليقك على الطلب",
    "Select Issue type":"حدد نوع العطل",
    "Submit":"ارسال",
    "this is comment":"هنا تعليق",
    "Thank you!":"شكرا لك",
    "Your offer is under review. Please wait for up to 24 hr for Musan team to reply.":"عرضك قيد المراجعة. يرجى الانتظار 24 ساعة وسيقوم فريق مصان بالرد عليكم",
    "Error while adding bank details":"خطأ أثناء إضافة التفاصيل البنك",
    "Your Order":"طلبك",
    "Cities":"مدن",
    "Completed order":"الطلب جاهز",
    "Traveled distance":"المسافة المقطوعة",
    "Help on this order":"مساعدة في هذا الطلب",
    "Next Step":"الخطوة التالية",
    "Call client":"الاتصال على العميل",
    "Open Chat":"المحادثة",
    "Distance":"المسافة",
    "Total Price":"السعر الكلي",
    "Tracking":"تتبع",
    "Finish work":"إنهاء العمل",
    "Accounting":"الحسابات",
    "Current balance":"الرصيد الحالي",
    "Account settings":"إعدادت الحساب",
    "Settings":"الإعدادات",
    "Workshop e-mail":"البريد الإلكتروني للورشة",
    "Commercial registration number":"رقم السجل التجاري",
    "Invalid Details":"التفاصيل غير صحيحة",
    "Add & Save":"إضافة وحفظ",
    "Bank Name":"اسم البنك",
    "Enter Bank Name":"أدخل اسم البنك",
    "Account Title":"عنوان الحساب",
    "Enter Account Title":"أدخل عنوان الحساب",
    "IBAN":"آيبان",
    "Enter IBAN Number":"أدخل رقم الآيبان",
    "Account Name":"إسم الحساب",
    "Your offers":"عروضك",
    "Add VAT":"إضافة الرقم الضريبي",
    "VAT number":"الرقم الضريبي",
    "Update":"تحديث",
    "Details":"تفاصيل",
    "Hidden requests":"الطلبات المخفية",
    "We have warranty for our work":"لدينا ضمان لعملنا",
    "UnHide":"إظهار",
    "Hide":"إخفاء",
    "Unavailable":"مشغول",
    "Available":"متفرغ",
    "New requests":"طلبات جديدة",
    "Offer value can't be empty":"لا يمكن أن تكون قيمة العرض فارغة",
    "Percentage can't be greater then 100":"لا يمكن أن تكون النسبة المئوية أكبر من 100",
    "Missing Info":"معلومات غير متوفرة",
    "Please select/complete all required fields":"يرجى تحديد / استكمال جميع الحقول المطلوبة",
    "Make an offer":"تقديم عرض",
    "Timing and cost":"المدة والتكلفة",
    "in SAR":"بالريال السعودي",
    "SR discount":"خصم ر. س",
    "in Percent":"في المئة",
    "% discount":"٪ خصم",
    "Offer type":"نوع العرض",
    "Description":"وصف",
    "Your Wallet":"محفظتك",
    "Earnings":"المكاسب",
    "Withdrawal":"سحب رصيد",
    "your earning is zero":"ربحك هو صفر",
    "Bank account":"حساب البنك",
    "Payments report":"تقرير المدفوعات",
    "Automatic withdrawal":"السحب التلقائي",
    "Every 3 days":"كل 3 أيام",
    "Balance":"الرصيد",
    "Status":"الحالة",
    "Offer finishes at":"العرض انتهى في",
    "Forgot Password":"هل نسيت كلمة السر",
    "Log In Instead":"تسجيل الدخول بدلا من ذلك",
    "SEND OTP":"إرسال OTP",
    "Don’t have an account?":"ليس لديك حساب؟",
    "SIGN UP":"تسجيل جديد",
    "Terms & Conditions":"الشروط والأحكام",
    "Terms":"الشروط والأحكام",
    "Understand":"استمرار",
    "Reset Password":"إستعادة كلمة المرور",
    "Tech":"فني",
    "Pickup Car":"سطحة",
    "Already have an account?":"هل لديك حساب؟",
    "Tool":"أداة",
    "Congratulations":"مبروك",
    "you have complected all steps successfully. Please wait for up to":"لقد أنهيت جميع الخطوات بنجاح. يرجى الانتظار حتى",
    "Display Name":"اسم العرض",
    "Loading":"تحميل",
    "Welcome":"أهلا بك",
    "Sign up information":"معلومات التسجيل",
    "Add pictures of places with availability":"أضف صورًا للأماكن مع توافرها",
    "Create Account":"إنشاء حساب",
    "Arrived":"وصلت",
    "The order has been completed, thank you please keep in touch":"شكراً لاتمام طلبك من مصان، درب السلامة",
    "Generate Report":"انشاء تقرير",
    "Client didn't pay final bill yet":"لم يدفع العميل الفاتورة النهائية بعد",
    "Maps":"خرائط",
    "KM":"كم",
    "Elite":"فئة النخبة",
    "Coming soon":"قريبا",
    "Please wait, A technician is coming to you.":"الفني في الطريق اليك، فضلاً انتظر",
    "A technician is arrived and checking your car.":"لقد وصل الفني لموقعك، سيبدأ الفني بفحص السيارة",
    "Congratulations 🎉, your report has been written":"مبروك 🎉 ، تم كتابة التقري  يمكنك طلب ورشة عبر التقرير الآن",
    "We are looking for the best technician for you, please wait":"نحن نبحث عن أفضل فني لك ، يرجى الانتظار",
    "Waiting":"منتظر",
    "Deliver Car":"تسليم السيارة",
    "Edits are waiting for approval":"التعديلات في انتظار الموافقة",
    "Part name":"اسم القطعة",
    "+ Add pictures":"إضافة الصور",
    "Images attached":"الصور المرفقة",
    "Item cost":"تكلفة البند",
    "Add part":"أضف قطعة",
    "Client has not accepted Edits Pending yet":"لم يقبل العميل التعديلات المعلقة بعد",
    "Client has not accepted Down Payment yet":"لم يقبل العميل الدفعة المقدمة حتى الآن",
    "Set the down payment":"حدد الدفعة الأولى",
    "Edit down payment":"تعديل الدفعة المقدمة",
    "Edit time and cost":"تعديل المدة والتكلفة",
    "Warning":"تحذير",
    "Car Pick up in progress. You can't make any changes until car pick complete":"السطحة في الطريق، لا تستطيع التغيير حتى وصول السطحة",
    "Ask Advance Payment":"طلب دفعة مقدمة",
    "Work is finished! Please enter the amount that you received.":"انتهى العمل! الرجاء إدخال المبلغ الذي تلقيته.",
    "Services":"الخدمات",
    "Comments & Rates":"تعليق وتقييم",
    "No review available":"لم يتم اضافة تعليق",
    "Select Service":"حدد الخدمة",
    "City":"مدينة",
    "Go back":"رجوع",
    "Back":"رجوع",
    "Specialization":"التخصص",
    "Industry":"الصناعية",
    "Incomplete details":"التفاصيل غير مكتملة",
    "Incomplete Data":"البيانات غير مكتملة",
    "Password must contain 4 character":"يجب أن تحتوي كلمة المرور على 4 أحرف",
    "Enter your number": "أدخل رقمك",
    "Phone Number": "رقم الجوال",
    "OR": "أو",
    "No Order Found!": "لم يتم العثور على طلب!",
    "Sign in with Apple": "قم بتسجيل الدخول باستخدام Apple",
    "Sign in with Google": "تسجيل الدخول باستخدام جوجل",
    "we will send you a SMS code to verify your number": "سنرسل لك رمز برسالة نصية قصيرة للتحقق من رقمك",
    "We will send you an SMS code to verify your number ": "سنرسل لك رمز برسالة نصية قصيرة للتحقق من رقمك",
    "Empty/Invalid Number": "لم يتم ادخال الرقم/ غير صالح",
    "Continue": "استمرار",
    "Mobile verification": "تفعيل الجوال",
    "Wrong number?": "الرقم غير صحيح؟",
    " Resend the code ": "أعد إرسال الرمز",
    "Verify Number": "تحقق من الرقم",
    "Latest orders": "أحدث الطلبات",
    "Rate Now": "قيم الآن",
    "We did a very good job the last time, order again now to enjoy our excellent services!": "لا تترد في طلب الخدمة مرة أخرى، أنت عميلنا وحنا بخدمتك بأي وقت، أطلب الآن",
    "Let’s do business again!": "يلا أطلب مرة ثانية",
    "Workshop location":"موقع الورشة",
    "Part cost": "تكلفة القطع",
    "Order #":"رقم الطلب",
    "It seems that you don’t have any active order yet, click on the button below to make your first order now.":"هلا وسهلاً فيك نورت مصان، تفضل بتقديم طلبك الأول، فريقنا بخدمتك دائماً",
    "There's no order yet!":"لا يوجد طلب حتى الآن!",
    "Special Offer":"عرض خاص",
    "You can take up to 20% off if you use our app to find your mechanic.":"يمكنك الحصول على خصم يصل إلى 20٪ إذا كنت تستخدم تطبيقنا للعثور على الورشة المناسبة لك.",
    "Cash on Delivery":"الدفع عند الاستلام",
    "Final Bill":"الفاتورة النهائية",
    "view":"عرض",
    "View":"عرض",
    "Create account": "إنشاء حساب",
    "I need help from a technician": "أحتاج إلى مساعدة من فني",
    "YES": "نعم",
    "Proceed to\norder now": "أعرف العطل، أطلب الآن",
    "If you don't know the issue, choose no and we will send you a technician to your location to help you identify the problem."
        : 'إذا كنت لا تعرف المشكلة ، فاختر "لا" وسنرسل لك فنيًا إلى موقعك لمساعدتك في تحديد عطل سيارتك.',
    "20% Off": "20٪ خصم",
    "You can take up to 20% off if you use our app to find your mechanic": "يمكنك الحصول على خصم يصل إلى 20٪ إذا كنت تستخدم تطبيقنا للعثور على الورشة المناسبة لك",
    "More Details": "المزيد من التفاصيل",
    "Call For Help": "اطلب المساعدة",
    "Call our verified technician to get help ": "اتصل بمهندس مصان للحصول على المساعدة المجانية",
    "Call Now": "اتصل الان",
    "WorkShop offers": "عروض جديدة",
    "WorkShop offers.": "العروض المقدمة",
    "No Offer Found!": "لم يتم ارسال عروض حتى الآن!",
    "Car type": "نوع السيارة",
    "No Report Found": "لم يتم طلب تقرير",
    "NO": "لا",
    "Chat with workshop": "محادثة مع المركز",
    "Price Negotiate": "تفاوض على السعر",
    "My cars": "سياراتي",
    "Thank You!": "شكراً لك",
    "Thanks for using Musan app": "شكرا لاستخدامك تطبيق مصان",
    "You can now track your order status on the order details screen": "يمكنك الآن تتبع حالة طلبك على شاشة تفاصيل الطلب",
    "Back Home": "العودة إلى الشاشة الرئيسية",
    "Special Discount Offer Coming Soon!": "قريباً سيتم ارسال عروض خصم لكم، ترقبو...",
    "Your Offers": "عروضك",
    "Order From Reports": "طلب من التقارير",
    "Verified Shop": "معتمد",
    "Offer Warranty": "يوفر ضمان",
    "Duration": "المدة",
    "You rejected this offer": "لقد رفضت هذا العرض",
    "Please rate and comment this workshop": "يرجى التقييم وإضافة تعليق لخدمة الورشة",
    "Rate": "تقييم",
    "Feedback": "رأي العميل",
    "Select Star Rating": "حدد كم نجمة",
    "Please Write review": "الرجاء كتابة تقييمك",




    "0 Offer": "0 عرض",
    "By Average Price": "حسب متوسط السعر",
    "In Progress": "في تقدم",
    "By Time &  Days": "حسب الوقت والأيام",
    "Sort": "نوع",
    "Filter Reset":"استعادة الفلتر",
    "Reset": "إعادة ضبط",
    "Fixing": "إصلاح السيارة",
    "By Price": "حسب السعر",
    "By Order No": "حسب رقم الطلب",
    "By Date": "حسب التاريخ",
    "Sort Reset": "استعادة النوع",
    "Deliver": "تسليم السيارة",
    "Arrive & Deal": "الوصول والاتفاق",
    "Picking up": "نعم",
    "On the way": "في الطريق",
    "Error": "خطأ",
    "SAR OFF": "خصم ريال سعودي",
    "% OFF": "٪ خصم",
    "Do you need to pick up your car?": "هل تحتاج سطحة لنقل سيارتك؟",
    "Profile has been updated successfully": "تم تحديث الملف الشخصي بنجاح",
    "Profile Updated": "تم تحديث الملف الشخصي",
    "Workshop service": "خدمة الورشة",
    "Request successful": "تم قبول الطلب بنجاح",
    "Offer accepted": "تم قبول العرض",
    "Successful": "عملية ناجحة",
    "Select Location": "اختر موقعا",
    "Your order has been booked": "تمت عملية الطلب",
    "Order Booked": "تم الطلب",
    "Your service has been booked": "تم تحديد خدمتك",
    "Service Booked": "تم طلب الخدمة",
    "Email Must Contain @": "يجب أن يحتوي البريد الإلكتروني على @",
    "Mobile number or e-mail": "رقم الجوال أو البريد الإلكتروني",
    "First Name": "الاسم الأول",
    "Last Name": "الكنية",
    "Enter e-mail": "أدخل البريد الإلكتروني",
    "Something went wrong": "هناك خطأ، حاول مرة أخرى",
    "Mobile number": "رقم الجوال",
    "Code has been resent.": "تم اعادة ارسال الرمز.",
    "Code Resent": "تم ارسال الرمز",
    "Code has been sent to": "تم إرسال الرمز إلى",
    "Code sent": "تم ارسال الرمز",
    "Verification Failed": "فشل التحقق",
    "Verification completed": "اكتمل التحقق",
    "Invalid code": "الرمز غير صحيح",
    "Edit": "تعديل",
    "Invalid Number": "الرقم غير صالح للاستخدام",
    "Please enter complete number": "الرجاء إدخال الرقم الكامل",
    "Terms & Condition": "الشروط والأحكام",
    "Log in with Google": "تسجيل الدخول عبر جوجل",
    "Resend the code": "أعد إرسال الرمز",
    "Verification code": "رمز التأكيد",
    "ChooseTheLanguage": "اختار اللغة",
    "Next": "التالي",
    "Step 2 of 4": "الخطوة 2 من 4",
    "Forgot password ?": "نسيت كلمة المرور ؟",
    "Finish": "إنهاء",
    "Skip": "تخطي",
    "Full Name": "الاسم كامل",
    "Workshop Name": "اسم الورشة",
    "Workshop E-mail": "البريد الالكتروني للورشة",
    "E-mail": "البريد الالكتروني",
    "Password": "كلمة المرور",
    "Workshop": "الورشة ",
    "Client": "العميل",
    "Create an account": "أنشئ حساب",
    "Log in instead": "استبدال بتسجيل الدخول ",
    "Facilitating agreements between clients and workshops": "تسهيل الاتفاقيات بين العملاء والورش",
    "The client can follow the maintenance process from his home": "يمكن للعميل متابعة عملية الصيانة من منزله",
    "Receipt and delivery of the order without meeting": "استلام وتسليم الطلب دون الحاجة لمقابلة الورشة",
    "Workshop Account": "حساب الورشة",
    "Sponsor’s name": "اسم الكفيل",
    "Department": "القسم",
    "Location": "موقع الورشة",
    "Facility": "المنشأة",
    "Commercial register": "السجل التجاري",
    "Electronic payments account number": "رقم حساب للدفع الالكتروني",
    "Upload a picture": "رفع صورة",
    "Add pictures of your places with availability": "أضف صورًا لمكان عملك",
    "Save": "حفظ",
    "Skip for later": "تخطي لوقت لاحق",
    "Log in to your account": "تسجيل الدخول إلى حسابك",
    "E-mail or mobile number": "البريد الالكتروني أو رقم الجوال",
    "mobile_number": "رقم الجوال",
    "Login": "تسجيل الدخول",
    "Send a code to my e-mail": "ارسل رمز التحقق الى البريد الالكتروني",
    "Send verification code": "أرسل رمز التحقق ",
    "We will send a verification code to your mobile number.": "سوف نرسل رمز التحقق إلى رقم جوالك.",
    "Confirm": "تقييم",
    "Change mobile number": "تغيير رقم الجوال",
    "We’ve sent a code to a mobile number ending on **11": "لقد أرسلنا رمزًا إلى رقم الجوال الذي ينتهي بـ ** 11",
    "Confirm password": "تأكيد كلمة المرور",
    "Create a new password": "أنشئ كلمة مرور جديدة",
    "Message": "الرسائل",
    "Orders": "الطلبات",
    "Profile": "الملف الشخصي",
    "Home": "الرئيسية",
    "Welcome, Workshop!": "مرحبا بك يا خبير الورشة",
    "New service": "خدمة جديدة",
    "Having a new announcement ?": "هل لديك إعلان جديد ؟",
    "Share it": " مشاركة",
    "View all": "عرض الكل",
    "Your announcements": "إعلاناتكم",
    "New services request": "طلب خدمات جديدة",
    "Clients’s Questions": "أسئلة العميل",
    "Client question": "سؤال العميل",
    "I have a question and I need answer ...": "لدي سؤال وأحتاج إجابة ...  ",
    "Client Name": "اسم العميل",
    "Sep 20, 12:00 PM": "20 سبتمبر ، 12:00 مساءً",
    "+123456788": "+123456788",
    "Toyota Land Cruiser, white": "تويوتا لاند كروزر، ابيض",
    "glass repair": "إصلاح الزجاج",
    "Client’s comment here": "هنا تعليق العميل",
    "News of our workshop": "أخبار الورشة لدينا",
    "Hello Clients! We are glad to inform you..": "مرحبا عملائنا الكرام، يسعدنا إبلاغكم .. ",
    "Workshop offers": "عروض الورشة",
    "Filter": "فلتر",
    "200": "200\$",
    "has sent a payment of": "تم ارسال دفعة بقيمة",
    "21/10/2020 | 10:45 AM": "21/10/2020 | 10:45 صباحًا",
    "New Announcement": "إعلان جديد",
    "Add a new announcement": "أضف إعلان جديد",
    "Announcement header": "عنوان الإعلان",
    "Announcement text": "نص الإعلان",
    "Upload up to 6 pictures": "تحميل كحد أقصى 6 صور",
    "Post": "بريد",
    "Offer name": "اسم العرض",
    "№ 123457870": "№ 123457870",
    "Toyota Land Cruiser": "تويوتا لاند كروزر",
    "Process: 10%": "العملية: 10٪",
    "Process:": "تحت الإجراء: ",
    "24 July 2020": "24 يوليو 2020",
    "Order placed": "تم الطلب",
    "25 July 2020": "25 يوليو 2020",
    "Estimate completion date": "تاريخ الانتهاء المقدر",
    "Send a offer": "أرسل عرضا",
    "Step 1": "الخطوة 1",
    "Sep 20,2020 | 12:00 PM": "20 سبتمبر 2020 | 12:00 مساء",
    "Step 2": "الخطوة 2",
    "Step 3": "الخطوة 3",
    "In progress": "في تقدم",
    "Workshop name": "اسم الورشة",
    "Sponsor": "كفيل",
    "India": "الهند",
    "Edit Profile": "تعديل الملف الشخصي",
    "FAQ": "الأسئلة الشائعة",
    "Deactivate account": "تعطيل الحساب",
    "client@mail": "client@mail",
    "+123456778": "+123456778",
    "Order Name": "اسم الطلب",
    "Your orders": "طلباتك",
    "№1245678": "№1245678",
    "Send a message": "أرسل رسالة",
    "Search for messages and users": "ابحث عن الرسائل والمستخدمين",
    "Hello Client! Your order is": "يا هلا فيك نورتنا، طلبك هو ...   ",
    "11:34 AM": "11:34 صباحًا",
    "Offer Name": "اسم العرض",
    "4.5/5": "4.5/5",
    "1 km away": "1 كم",
    "Information": "معلومات",
    "Pictures": "الصور",
    "Request a services": "طلب خدمة",
    "Car information": "معلومات السيارة",
    "Need your car fixed": "سيارتك تحتاج للصيانة",
    "Car Information": "معلومات السيارة",
    "Enter your car information here": "أدخل معلومات سيارتك هنا",
    "Car company": "شركة السيارة",
    "Honda": "هوندا",
    "Mercedes": "مرسيدس",
    "Car model": "بيانات السيارة",
    "Car Color": "لون السيارة",
    "Red": "أحمر",
    "White": "أبيض",
    "Car transmission": "نوع جيرالسيارة",
    "Setting": "الاعدادات",
    "Notification settings": "اعدادات الاشعارات",
    "E-mail notification": "إشعارات البريد الإلكتروني",
    "Accepted request": "طلب مقبول",
    "Declined request": "طلب مرفوض",
    "Profile settings": "إعدادات الملف الشخصي",
    "Language": "اللغة",
    "Arabic": "عربي",
    "English": "English",
    "Select language": "اختر اللغة",
    "Preferred payment method": "طريقة الدفع المفضلة",
    "VISA *0911": "فيزا * 0911",
    "Add Another payment method": "أضف طريقة دفع أخرى",
    "Recent payment": "آخر عملية دفع",
    "21/10/2020": "21/10/2020",
    "123457870": "123457870",
    "Add a payment method": "إضافة طريقة الدفع",
    "Please choose payment method": "الرجاء اختيار طريقة الدفع",
    "Credit / Debit card": "بطاقة الائتمان / الخصم",
    "Apply App": "تأكيد التطبيق",
    "Mada card": "بطاقة مدى",
    "Add a credit card": "أضف بطاقة ائتمان",
    "Please fill your information below": "يرجى ملء المعلومات الخاصة بك أدناه",
    "Cardholder Name": "إسم صاحب البطاقة",
    "Add": "إضافة",
    "Card Number": "رقم البطاقة",
    "Expiration Data": "تاريخ الإنتهاء",
    "CVC": "CVC",
    "Ask a question": "طرح سؤال",
    "Ask us a question or report an issue here": "اسألنا سؤالاً أو أبلغ عن مشكلة",
    "Enter your message": "أدخل رسالتك",
    "Send": "إرسال",
    "Welcome,Client": "يا هلا فيك نورتنا",
    "Having a new question?": "هل لديك سؤال جديد؟",
    "Ask it": "  إسأل",
    "Announcements": "الإعلانات",
    "Latest Offers": "آخر العروض",
    "4.5": "4.5",
    "Service estimate price": "سعر الخدمة المقدر",
    "Estimate completion time": "مدة الانتهاء المقدرة",
    "5 days": "5 أيام",
    "Learn more": "المزيد",
    "Announcement Header": "عنوان الإعلان",
    "More information": "مزيد من المعلومات",
    "Request a service": "اطلب خدمة",
    "Add a description": "إضافة وصف",
    "Free comment": "تعليق",
    "Faults": "الأعطال",
    "Payment method": "طريقة الدفع او السداد",
    "Car color": "لون السيارة",
    "Maintenance department": "قسم الصيانة",
    "Order now": "اطلب الآن",
    "Order Now": "اطلب الآن",
    "Fault": "العطل",
    "Black": "أسود",
    "A": "أ",
    "B": "ب",
    "Navigate": "تحديد الوجهه عبر جوجل ماب",
    "Don't show again": "عدم الظهور مرة أخرى",
    "Go to Workshop on Map": "اذهب إلى الورشة عبر جوجل",
    "cash": "نقد",
    "credit card": "بطاقة ائتمان",
    "Filters": "الفلاتر",
    "Price": "السعر",
    "Show result": "أظهر النتيجة",
    "Option 1": "اختيار 1",
    "Option 2": "اختيار 2",
    "Option 3": "اختيار 3",
    "Up to 100": "كحد أقصى 100\$",
    "Order no":"رقم الطلب",
    "order no":"رقم الطلب",
    "Order Details":"تفاصيل الطلب",
    "First name": "الاسم الأول",
    "Last name": "الاسم الأخير",
    "Back to Home": "العودة إلى الرئيسية",
    "Workshop Offers": "عروض الورشة",
    "OK": "نعم",
    "Final Payment Received": "تم استلام الدفعة النهائية",
    "Bank Account": "حساب البنك",
    "Enter": "إدخال",
    "Order Number:": "رقم الطلب:",
    "Client Name:": "اسم العميل:",
    "Approved": "وافق",
    "Approval Status:": "حالة القبول:",
    "waiting": "انتظار",
    "Amount:": "قيمة:",
    "pending": "انتظار",
    "Click to receive": "انقر للاستلام",
    "Transferred": "تم التحويل",
    "Transaction:": "عملية حوالة:",
    "Date:": "تاريخ:",
    "Request ID:": "كمية:",
    "Withdraw History": "تاريخ السحب",
    "Withdrawal History": "تاريخ السحب",
    "No Account Found": "لم يتم العثور على حساب",
    "hours": "ساعات",
    "minutes": "دقائق",
    "Withdrawal time": "وقت السحب",
    "Withdrawal method": "طريقة السحب",
    "Every 5 days": "كل 5 أيام",
    "Every": "كل",
    "Every 10 days": "كل 10 أيام",
    "Every 15 days": "كل 15 أيام",
    "Every 30 days": "كل 30 أيام",
    "Client wants to negotiate\n the offer for": "العميل يرغب في التفاوض على العرض",
    "Order ID": "الطلب رقم",
    "Nothing found!!!": "لا يوجد بيانات",
    "Header Text": "عنوان النص",
    "Having Offers": "الحصول على عروض",
    "Picking up the car": "نقل السيارة",
    "Your Orders": "طلباتك",
    "LOG IN":"تسجيل الدخول",
    "What's  your car":"ما هي سيارتك؟",
    "Total Cost":"التكلفة الإجمالية",
    "Order Number":"رقم الطلب",
    "days":"الأيام",
  };
}
