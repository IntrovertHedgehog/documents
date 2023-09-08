Econs' RA job:
To-do list Khoa:

    Share code for diff-in-diff analysis that Van Minh can start working from

    If you have a code matching the district names in the university openings data with GSO code, please share that


To-do list for Van Minh:

    Calculate the correlation between education and one corruption measure in PAPI

        You can show this using a bar diagram with one bar for each corruption level

    Set up code to determine districts of firms (PCI) using their geocodes, match with GSO district codes

    Set up code to determine districts of individuals (PAPI) using the Huyen / tenhuyen variables, match each individual with a GSO district codes

    Final goal: set up diff-in-diff showing the effect of university openings on one corruption outcome in PAPI and one corruption outcome in PCI (for this, use code provided by Khoa as starting point)
    
    
    
    
match papi with gso, prefer earlier year if splitting is more than merging

joining the data table to make a working diff-in-diff analytsis: id, firm, year, year_rel_to_uni, uni_opening, ever_has_uni
map_api: AIzaSyChYCDrogjB7s8eUlP69GvNYa8VJZ92F94 

✅️☹️In ấn (đồ chơi

Gửi email đăng kí thành công
xác nhận	

echo 'export PYENV_ROOT="/home/linuxbrew/.pyenv"' >> ~/.zshrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc


Helu mọi người. Hiện tại team prog trong VNYA Run đang có một task là soạn câu đố cho Big Game. Và với một quan sát là VNYA mình có rất nhiều chiến thần về làm câu đố các thể loại, nên prog đang muốn tận dụng những chiến thần này để cùng prog thực hiện task (tất nhiên là prog vẫn đảm nhận vai trò chính). Những bạn nào volunteer thì hãy vote vào poll sau nha.  

Để give context cho mn:

1/ Theme năm nay là người chơi vào vai những nhà mật mã học, giải mật mã (i.e. câu đố) để tìm ra những thành phố sắp bị đánh bom bởi khủng bố và cứu ĐNÁ. Người chơi trong suốt game sẽ cố gắng giải 1 trong 2 loại mật mã.
  a. Mật mã nhỏ -> giải mỗi mật mã nhỏ sẽ tìm được 1 thành phố bị ném bom
  b. Mật mã lớn -> giải 4 mật mã lớn, ghép lại thành một mật khẩu sẽ tìm được 8 thành phố bị ném bom
Vì những câu đố này phụ thuộc vào ý tưởng nên team muốn tận dụng tối đa những ý tưởng sáng tạo của toàn VNYA.
2/ Những câu đố nhỏ (a) sẽ có đáp án liên quan tới một thành phố ở ĐNÁ (bằng cách chỉ ra tên, tọa độ, landmark, etc). Và preferably là có thể generalize ra cho những thành phố khác. Ví dụ: câu đố chữ có đáp án là HoGuom (để chỉ Hà Nội), nhưng sửa câu đố để có đáp án là AngkorWat hay địa điểm nào đó cũng được.
3/ Những câu đố lớn (b) sẽ có đáp án là một dãy chữ số, để có thể cùng những câu đố khác ghép thành một mật khẩu.
4/ Khi mọi người ngoài prog tham gia thì chỉ cần tìm idea sơ bộ, và prog sẽ đảm nhận phần hoàn thiện chi tiết
5/ Deadline nộp idea là 1/7 nếu mn volunteer.

physical quiz để tăng độ khó câu đố. Đây là một dạng khá hay để tăng độ khó câu đố. Nhưng sẽ có đội chơi chỉ bắt đầu giải đố khi tới trạm cuối. Vậy thì khá là ức chế, nên Minh nghĩ không nên.

Guidebook thì sẽ có:
- Storyline
- Mechanism
- Side quest
- Danh sách thành phố
- Bản đồ khu vực chơi (?)
- Hướng dẫn an toàn, disclaimer,..
- Appendix một số chiến thuật thường dùng 


Help me sort these messages to "casual talk", "diabetic medical question",  "non-diabetic medical question", and "other"
Hi!
category: casual talk
How are you?
category: casual talk
what is the symptoms of type-2 diabetes?
category: diabetic medical question
How should I store my insulin?
category: diabetic medical question
How to manage my diet?
category: diabetic medical question
How to prevent tubercolosis?
category: non-diabetic medical question
When is a circumcision required?
category: non-diabetic medical question
Is Python a backend language?
category: other
Is smoking bad?
category:



You are HealthBot, a AI chat bot engine based on OpenAI LLM. You are created to help diabetic patients answering medical queries. Reply to the following message from patient:
Patient: Hi!
You:

behaviour:
connect: 
- if physician already connected, deny
- if any physician online, choose the first one
- if no physician is online, apologize

disconnect:
- if physician is connected, disconnect
- if physician is not connected, deny

connect to server-served patient
web-portal disconnect from patient

Mn ơi cho Minh xin ý kiến về cách sử dụng thẻ bài nha, mn xem thấy ổn chưa:
- Thẻ phòng thủ: Chơi xong thì phát tại trạm luôn. Nếu được nhận thêm hệ thống từ bonus store thì sẽ phát thêm ở trạm cuối. Công dụng chủ yếu là chụp hình với Banner và mua bonus.
- Thẻ Bonus: Người chơi tương tác với Bonus store thông qua Messenger và mod, và có thể dùng bonus bất kì lúc nào kể cả khi chưa lấy thẻ. Thẻ Bonus là để tượng trưng cho việc người chơi đã hoàn thành giao dịch, họ có thể collect thẻ và trả lại thẻ phòng thủ ở bất kì trạm chơi nào (nếu trạm vẫn còn thẻ in stock). Người chơi dùng bonus xong không cần thẻ lại thẻ.
- Thẻ Ngôi sao hy vọng: Mỗi đội được phát 6 (hoặc ít hơn) thẻ này ở trạm đầu, khi muốn dùng NSHV thì đưa cho GM. Đưa xong ko lấy lại.
Công dụng chủ yếu là cho người cầm cái gì đó cho nó vui vui thôi. NSHV thì có dụng hơn chút.

print_prized: 1 mặt, màu A4, giấy dày x 2 bản
print_prizednot: 1 mặt, màu A4, giấy dày x 20 bản
print_map: 1 mặt, màu A3, giấy dày x 20 bản
print_NTT, print_VD: 2 mặt, màu size thẻ bài, giấy thường, ép nhựa x 30 bản
print_NSHV: 2 mặt, màu size thẻ bài, giấy thường, ép nhựa x 100 bản
print_C: 2 mặt, màu size thẻ bài, giấy thường, ép nhựa x 450 bản
print_B: 2 mặt, màu size thẻ bài, giấy thường, ép nhựa x 416 bản
print_A: 2 mặt, màu size thẻ bài, giấy thường, ép nhựa x 224 bản

Em gửi lại số lượng nhé chị
print_prized: A4 x 1 bản
print_prizednot: A4 x 20 bản
print_nametag: 36 cái
print_nametag2: 100 cái
print_map: A3 x 20 bản
xén giúp em nametag với map ạ. Em cảm ơn.

print_nametag3: In màu, 1 mặt, giấy thường, khổ 5.3cm x 8.3cm, 20 bản

Những file sau đều in màu, 2 mặt (dạng thẻ bài), giấy thường, khổ 5.3cm x 8.3cm, ép plastic
print_a: 210 bản
print_a2: 20 bản
print_b: 160 bản
print_b2: 210 bản
print_c: 180 bản
print_c2: 200 bản
print_c4: 20 bản
print_NSHV: 100 bản
print_NTT: 30 bản
print_VD: 30 bản

My current model has that, but that problem is:
1. My model finds the related documents (a)
2. Query from the new model. But there's no guarantee it will use (a) as its source, or 

PR dev + prod server
switch to prod server frontend (PR)

check talkjs webhook error on prod (wwwwwwwwwwwwwwwwhy the fuck)

GM - card usage: copy guidebook contentcontentcontent

Mod training - 2 channels: player & internal channelchannelchannelchannel
- player channel: messenger
    + queries resolution: rules, clarifications, route guide
    + bonus store - purchases: taking order and grant items
    + bonus store - functional: Puzzle hint will be given through this channel to players
    + Big game - big puzzle: release city list when given big puzzle's answer
- internal channel: messenger - formatted messages only
    + (GM) score update: updating score & station achievement
    + (GM) items update: update puzzle pass usage
    + (GM) inventory update: update if player received/traded their item card
- internal channel: google sheet - inventory
    + based on the internal messenger channel to update player's inventory and achievement
- internal channel: google sheet - progress
    + based on the internal messenger channel to update player's chronical progress, detect lagging/station skipping

[ ] Make the sheets
[ ] Find out why prod talkjs not working

làm file excel ghi thời gian, địa điểm (trạm số mấy, etc.) và công việc cần làm. Những việc cần có:
- ăn sáng?
- Tập hợp, điểm danh, phổ biến lại schedule và tổng quan operation (GM khi tới trạm mình thì làm, còn ở trạm khác thì chơi, mod quản lý hoạt động trong sheet nháp/messenger nháp)
- check log
- thuê xe đạp?
- test game buổi sáng: test 2 trạm, làm 3-4 sidequests.
- ăn trưa
- test game buổi chiều: test 4 trạm, làm sidequests còn lại (best effort)
- Về trạm cuối, Nhận xét, chỉnh sửa
- Đi về

Telemedicine is enabling a new standard of care by keeping patients better connected with their providers, thereby improving better access to clinicians and specialists (especially for rural patients), achieving better economic efficiencies, and providing a safer environment  both patients and health care workers.

This project seeks to investigate how to enhance the telemedicine technologies with AI and IOT to provide a more seamless monitoring and health care delivery process. Integrating wearables, analyzing the data from these wearables, creating AI algorithms based on the provided data, and improving the process of taking patient history with AI, and unifying them onto a platform will be the key focus of this project. 

The student will be required to understand the requirements, research the best practice, and implement a prototype of the platform for this FYP.
acbdef

các gm soạn script và lead thêm các phần cố định (hỏi nshv, vé đố, etc.)
trạm a: dùng dây nhỏ tránh bondage
trạm b: đổi thành trò buộc cốc lên cái dĩa để trên đầu rồi chuyền nước, chơi trên bãi cỏ
trạm c: lvl1 lvl2 làm dài ra, lvl2 lvl3 rộng lỗ ra một chút tránh speedrun, lvl3 làm bớt lỗ lại, làm phẳng các chỗ gập gềnh bằng băng dính 
trạm d: dùng dây chun + dây thừng ngâm muối để ko bị tuột dây, điều chỉnh độ khó level 1-2-3 thành 2 tầng - 4 tầng - 5 tầng (test lại ngày làm prop)
Trạm f: làm map cố định cho khu vực chơi

Puzzle: puzzle của Chi có lỗi ở phần Laksa (viết thành Laksg)

mỗi trạm có:
tọa độ, link google map, hình ảnh, gm

các trạm:
T



A  ơi mai anh qua xem giúp e 2 tiệm này để in thử + báo giá nha
https://goo.gl/maps/vuQ1EKP3SmwA7t579
https://goo.gl/maps/xH3hQ5wo1heF7i6a7
Số lượng in (theo file trong link): in màu, 2 mặt (dạng thẻ bài), giấy thường, khổ 5.3cm x 8.3cm, ép plastic
- print_a: 5 bản
- print_b: 10 bản
- print_b2: 10 bản
- print_c2: 195 bản

- Measuring cup 1L x 5 cái
- Thau nhỏ size 260 x 3 cái
- Vải bịt mắt (khăn quàng đỏ?) x 5 cái
- In thẻ bài (đã ib chi tiết cho a Kiên)

- kết thúc: serene garden, dự bị eton house (bayfront pavilion)
- HQ: malay garden, dự bị trạm L (Bayfront Pavilion), K (Serene Garden), H (Fruits and Flowers)

Chỉnh sửa chính:
- cửa hàng vật phẩm: người chơi không thông qua Mod để mua đồ nữa, mà tương tác với GM để mua vật phẩm và trả tiền tại chỗ
- chi tiết thêm cách mấy thẻ bài hoạt động, chú ý là thẻ Nhà Tiên Tri hơi khác mấy lá khác, GM xem để ko bị nhầm
- scenario: người chơi nhận thưởng nhưng GM thiếu thẻ. Lúc này thì GM báo với mod để ghi mod ghi nợ, tới trạm tiếp theo thì GM trả nợ cho ng chơi
- Cheat Sheet cho cú pháp tin nhắn

- lá chắn hạng A: 5 bản
- lá chắn hạng B: 10 bản
- lá chắn hạng Bx2: 10 bản
- lá chắn hạng Cx2: 195 bảnbản

- Hoàn thành trạm ở mức 1 hoặc 3
- Hoàn thành nhiệm vụ phụ mức dễ
- Hoàn thành cả 10 nhiệm vụ phụphụphụphụ

- Hoàn thành trạm ở mức 2 hoặc 3
- Hoàn thành nhiệm vụ phụ mức khá
- Hoàn thành cả 10 nhiệm vụ phụphụ

- Hoàn thành trạm ở mức 3
- Hoàn thành nhiệm vụ phụ mức khó
- Hoàn thành cả 10 nhiệm vụ phụ

Trạm chơi

người chơi đổi thẻ Lá chắn để nhận vật phẩmphẩm

- Người chơi chỉ được nhận tối đa một thẻ Nhà Tiên Tri bất kể số lượng đã mua, và khi sử dụng (thông qua người điều hành trên Messenger) thì không cần trả lại thẻ
- Người chơi nhận một thẻ Vé Đố mỗi khi mua vật phẩm này ở cửa hàng, và khi sử dụng xong thì phải trả lại cho quản trò

tương tác với quản trò ở trạm bất kì. Khi mua vật phẩm người chơi phải trả những thẻ bài tương ứng.
- nhắc nhở tham gia: Bắt đầu gửi được r, yêu cầu repond trước 23h59 14/8 (2 ngày)
- mail thoát waitlist: với mỗi người respond là ko tham gia được, bắt đầu đẩy người từ waitlist lên và gửi. sau hạn respond mail nhắc tham gia thì đẩy waitlist lên để thay thế. Yêu cầu repond trước 16/8 (2 ngày)
- Xác nhận tham gia: Gửi cuốn chiếu cho những người đã repond mail Nhắc nhở tham gia để người ta nắm lịch brief càng sớm càng tốt (biết trước tối thiểu 1 ngày)
- Briefing ngày 18/6

timeline d-day
route
nhà tiên tri - kiểm câu đố
mod nào quản lý team nào

Martin's feedback
nsws
sáng: 29
chiềuchiềuchiềuchiều

checklist những thứ cần làm, xếp theo ưu tiên:
- Làm prop game (ít nhất 3 bộ mỗi trạm):
  + trạm a (chuyền bóng): cắt dây và xếp vào từng bộ
  + trạm b (đổ nước): buộc dĩa giấy và cốc, 5 cái 1 bộ (5 bộ)
  + trạm c (make it move): sửa course như đã comment hôm trước
  + trạm d (xây tháp): làm dây (sửa sao cho nó không tụt), test 
  + trạm e (thảm bay): cắt vải?
  + trạm f (bãi mìn): làm mìn
- Kiểm log và làm log list cho D-Day (tính thêm dự phòng)
- pack goodie bagbagh
- bo góc thẻ bài
- chia thẻ bài cho từng trạm -> gói lại


- (done) làm log list: dồ chơi ở trạm, bài, certi, map, đố, phần thưởng, panel giải thưởng
- (done) hint câu đố cho nhà tiên tri
- (done) in câu đố, assign câu đố cho team,
- hoàn thành operation sheet
- (done) viết tên name card
- làm form nộp đáp án + công thức validationvalidation
- (done) lấy wristband, bỏ bột sữa vào goodie bag
- (done) mua dây thừng làm thêm 1 bộ truyền nước
- (done) mua bút dạ trắng viết tên nametag
- (done) mua thêm prop contingency
- (done) kiểm nhân sự
- (done) làm acc clone để add người chơi vào groups
- (done) thuê loa trao giải
- cheat sheet cho GM, Mod trong data centre
- (done) mail người chơi + lập group chat cho mod
- cú pháp nộp đáp án gửi cho người chơi + thành phố

- lấy đồ shopee ở collection point
- họp với martin
- fyp với thầy
- reply to jiayi
- resolve backend errorerror



Xin chào các bạn, mình là Văn Minh - đại diện cho BTC, còn bạn Anh Khoa và Việt Anh là moderator phụ trách của nhóm. Thay mặt cho VNYA, chào mừng bạn tham gia sự kiện VNYA RUN! 2023: Unbreakable Code. Đây sẽ là kênh liên chính thức của BTC với đội của bạn. Mọi thông tin và liên lạc trong suốt quá trình chơi sẽ được trao đổi và cập nhật ở đây. Chúng mình sẽ giải thích rõ hơn trong buổi zoom briefing ngày mai (18/8). Thông tin về buổi briefing đã có trong email được gửi tới các bạn. Đội chơi nhớ cử ít nhất một đại diện tham gia nhé. Xin cảm ơn và chúc mọi người chơi game vui vẻ!

- Vũ Thảo Nguyên
- Nguyễn Minh Quang
- Trương Hoàng Quân
- Nguyễn Anh Minh

- bảo ngchoi tự mang giấy bút

chào mừng mn đến với buổi hướng dẫn cho sự kiện vnya run 2023 unbreakable code. 
Nội dung chính của ngày hôm nay là walkthrough những nội dung trong guidebook để đảm bảo mn
nắm rõ luật chơi và có sự chuẩn bị tốt nhất cho buổi chơi chính thức ngày mai

- Địa điểm xuxuất phát và thứ tự các trạm chơi sẽ được thông báo với mọi người qua 
group chat của nhóm ngay sau buổi briefing nhé.


- (done) fixed effect for age range
- (done) use 1 specs
- (done) add average outcome variable to the table
- (done) cluster the standard deviation
- (done) don't control for uni_educ when controlling for uni
- clarify: having a graph to show how many of the district were treated each year (ratio)
- clarify: survey weight fixed effect packages
- calrify: control age when uni open - binned fixed effect like age? -> event study graph
- clarify: treatment cutoff at 16yo-22yo -> 
- add row to show FE
- fix the code and send to Khoa
    

- install matlab
- ma1522 quizzes
- check other mod prequently task and add to todoist
- educ corruption
- fix the pipfile bug in empower backendbackend

[VNYA RUN 23 - Expense Claims, Feedback, Debrief]
Chào cả nhà iu VNYA. Sau sự kiện bom tấn VNYA RUN 2023 thành công siêu rực rỡ bùm chíu nhờ sự góp mặt hỗ trợ từ hơn 5000 ae gia đình mình thì Main Lead xin thông báo một số công việc hậu sự kiện nha (có tiền).

1. Điền Expense Claim: Ai chưa điền thì điền thêm còn ai điền rồi thì kiểm lại nhé. https://docs.google.com/spreadsheets/d/1rSf_UCdTK8tGA35idH_9_iHd84iHCPVdrICtiP7MOQc/edit#gid=0
2. Member Feedback: Xin góp ý năm sau làm tiếp: https://forms.gle/Nk8gojaT9gqqkbnV9
3. Debrief: 10pm, T7 02/02/2023. Mong được gặp lại mọi người tại: <Link Zoom hội đồng quản trị>  

Xin hết! Chúc cả nhà iu một tuần bán mình cho tư bản vui vẻ.

- drop 22, use Inf, export csv + graph (es)s
