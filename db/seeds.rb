# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.mongo_session['roles'].insert({ :name => role })
  puts 'role: ' << role
end
#puts 'DEFAULT USERS'
#User.create :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
#user = User.where(email: ENV['ADMIN_EMAIL']).first
#puts 'user: ' << user.name
#user.add_role :admin

# provinces and cities
Province.create({id: 11,name: "北京",cities_attributes: [{name: "东城区"},{name: "西城区"},{name: "崇文区"},{name: "宣武区"},{name: "朝阳区"},{name: "丰台区"},{name: "石景山区"},{name: "海淀区"},{name: "门头沟区"},{name: "房山区"},{name: "通州区"},{name: "顺义区"},{name: "昌平区"},{name: "大兴区"},{name: "怀柔区"},{name: "平谷区"},{name: "密云县"},{name: "延庆县"}]})
Province.create({id: 12,name: "天津",cities_attributes: [{name: "和平区"},{name: "河东区"},{name: "河西区"},{name: "南开区"},{name: "河北区"},{name: "红桥区"},{name: "塘沽区"},{name: "汉沽区"},{name: "大港区"},{name: "东丽区"},{name: "西青区"},{name: "津南区"},{name: "北辰区"},{name: "武清区"},{name: "宝坻区"},{name: "宁河县"},{name: "静海县"},{name: "蓟县"}]})
Province.create({id: 13,name: "河北",cities_attributes: [{name: "石家庄"},{name: "唐山"},{name: "秦皇岛"},{name: "邯郸"},{name: "邢台"},{name: "保定"},{name: "张家口"},{name: "承德"},{name: "沧州"},{name: "廊坊"},{name: "衡水"}]})
Province.create({id: 14,name: "山西",cities_attributes: [{name: "太原"},{name: "大同"},{name: "阳泉"},{name: "长治"},{name: "晋城"},{name: "朔州"},{name: "晋中"},{name: "运城"},{name: "忻州"},{name: "临汾"},{name: "吕梁"}]})
Province.create({id: 15,name: "内蒙古",cities_attributes: [{name: "呼和浩特"},{name: "包头"},{name: "乌海"},{name: "赤峰"},{name: "通辽"},{name: "鄂尔多斯"},{name: "呼伦贝尔"},{name: "兴安盟"},{name: "锡林郭勒盟"},{name: "乌兰察布盟"},{name: "巴彦淖尔盟"},{name: "阿拉善盟"}]})
Province.create({id: 21,name: "辽宁",cities_attributes: [{name: "沈阳"},{name: "大连"},{name: "鞍山"},{name: "抚顺"},{name: "本溪"},{name: "丹东"},{name: "锦州"},{name: "营口"},{name: "阜新"},{name: "辽阳"},{name: "盘锦"},{name: "铁岭"},{name: "朝阳"},{name: "葫芦岛"}]})
Province.create({id: 22,name: "吉林",cities_attributes: [{name: "长春"},{name: "吉林"},{name: "四平"},{name: "辽源"},{name: "通化"},{name: "白山"},{name: "松原"},{name: "白城"},{name: "延边朝鲜族自治州"}]})
Province.create({id: 23,name: "黑龙江",cities_attributes: [{name: "哈尔滨"},{name: "齐齐哈尔"},{name: "鸡西"},{name: "鹤岗"},{name: "双鸭山"},{name: "大庆"},{name: "伊春"},{name: "佳木斯"},{name: "七台河"},{name: "牡丹江"},{name: "黑河"},{name: "绥化"},{name: "大兴安岭"}]})
Province.create({id: 31,name: "上海",cities_attributes: [{name: "黄浦区"},{name: "卢湾区"},{name: "徐汇区"},{name: "长宁区"},{name: "静安区"},{name: "普陀区"},{name: "闸北区"},{name: "虹口区"},{name: "杨浦区"},{name: "闵行区"},{name: "宝山区"},{name: "嘉定区"},{name: "浦东新区"},{name: "金山区"},{name: "松江区"},{name: "青浦区"},{name: "南汇区"},{name: "奉贤区"},{name: "崇明县"}]})
Province.create({id: 32,name: "江苏",cities_attributes: [{name: "南京"},{name: "无锡"},{name: "徐州"},{name: "常州"},{name: "苏州"},{name: "南通"},{name: "连云港"},{name: "淮安"},{name: "盐城"},{name: "扬州"},{name: "镇江"},{name: "泰州"},{name: "宿迁"}]})
Province.create({id: 33,name: "浙江",cities_attributes: [{name: "杭州"},{name: "宁波"},{name: "温州"},{name: "嘉兴"},{name: "湖州"},{name: "绍兴"},{name: "金华"},{name: "衢州"},{name: "舟山"},{name: "台州"},{name: "丽水"}]})
Province.create({id: 34,name: "安徽",cities_attributes: [{name: "合肥"},{name: "芜湖"},{name: "蚌埠"},{name: "淮南"},{name: "马鞍山"},{name: "淮北"},{name: "铜陵"},{name: "安庆"},{name: "黄山"},{name: "滁州"},{name: "阜阳"},{name: "宿州"},{name: "巢湖"},{name: "六安"},{name: "亳州"},{name: "池州"},{name: "宣城"}]})
Province.create({id: 35,name: "福建",cities_attributes: [{name: "福州"},{name: "厦门"},{name: "莆田"},{name: "三明"},{name: "泉州"},{name: "漳州"},{name: "南平"},{name: "龙岩"},{name: "宁德"}]})
Province.create({id: 36,name: "江西",cities_attributes: [{name: "南昌"},{name: "景德镇"},{name: "萍乡"},{name: "九江"},{name: "新余"},{name: "鹰潭"},{name: "赣州"},{name: "吉安"},{name: "宜春"},{name: "抚州"},{name: "上饶"}]})
Province.create({id: 37,name: "山东",cities_attributes: [{name: "济南"},{name: "青岛"},{name: "淄博"},{name: "枣庄"},{name: "东营"},{name: "烟台"},{name: "潍坊"},{name: "济宁"},{name: "泰安"},{name: "威海"},{name: "日照"},{name: "莱芜"},{name: "临沂"},{name: "德州"},{name: "聊城"},{name: "滨州"},{name: "菏泽"}]})
Province.create({id: 41,name: "河南",cities_attributes: [{name: "郑州"},{name: "开封"},{name: "洛阳"},{name: "平顶山"},{name: "安阳"},{name: "鹤壁"},{name: "新乡"},{name: "焦作"},{name: "濮阳"},{name: "许昌"},{name: "漯河"},{name: "三门峡"},{name: "南阳"},{name: "商丘"},{name: "信阳"},{name: "周口"},{name: "驻马店"}]})
Province.create({id: 42,name: "湖北",cities_attributes: [{name: "武汉"},{name: "黄石"},{name: "十堰"},{name: "宜昌"},{name: "襄樊"},{name: "鄂州"},{name: "荆门"},{name: "孝感"},{name: "荆州"},{name: "黄冈"},{name: "咸宁"},{name: "随州"},{name: "恩施土家族苗族自治州"}]})
Province.create({id: 43,name: "湖南",cities_attributes: [{name: "长沙"},{name: "株洲"},{name: "湘潭"},{name: "衡阳"},{name: "邵阳"},{name: "岳阳"},{name: "常德"},{name: "张家界"},{name: "益阳"},{name: "郴州"},{name: "永州"},{name: "怀化"},{name: "娄底"},{name: "湘西土家族苗族自治州"}]})
Province.create({id: 44,name: "广东",cities_attributes: [{name: "广州"},{name: "韶关"},{name: "深圳"},{name: "珠海"},{name: "汕头"},{name: "佛山"},{name: "江门"},{name: "湛江"},{name: "茂名"},{name: "肇庆"},{name: "惠州"},{name: "梅州"},{name: "汕尾"},{name: "河源"},{name: "阳江"},{name: "清远"},{name: "东莞"},{name: "中山"},{name: "潮州"},{name: "揭阳"},{name: "云浮"}]})
Province.create({id: 45,name: "广西",cities_attributes: [{name: "南宁"},{name: "柳州"},{name: "桂林"},{name: "梧州"},{name: "北海"},{name: "防城港"},{name: "钦州"},{name: "贵港"},{name: "玉林"},{name: "百色"},{name: "贺州"},{name: "河池"}]})
Province.create({id: 46,name: "海南",cities_attributes: [{name: "海口"},{name: "三亚"},{name: "其他"}]})
Province.create({id: 50,name: "重庆",cities_attributes: [{name: "万州区"},{name: "涪陵区"},{name: "渝中区"},{name: "大渡口区"},{name: "江北区"},{name: "沙坪坝区"},{name: "九龙坡区"},{name: "南岸区"},{name: "北碚区"},{name: "万盛区"},{name: "双桥区"},{name: "渝北区"},{name: "巴南区"},{name: "黔江区"},{name: "长寿区"},{name: "綦江县"},{name: "潼南县"},{name: "铜梁县"},{name: "大足县"},{name: "荣昌县"},{name: "璧山县"},{name: "梁平县"},{name: "城口县"},{name: "丰都县"},{name: "垫江县"},{name: "武隆县"},{name: "忠县"},{name: "开县"},{name: "云阳县"},{name: "奉节县"},{name: "巫山县"},{name: "巫溪县"},{name: "石柱土家族自治县"},{name: "秀山土家族苗族自治县"},{name: "酉阳土家族苗族自治县"},{name: "彭水苗族土家族自治县"},{name: "江津市"},{name: "合川市"},{name: "永川区"},{name: "南川市"}]})
Province.create({id: 51,name: "四川",cities_attributes: [{name: "成都"},{name: "自贡"},{name: "攀枝花"},{name: "泸州"},{name: "德阳"},{name: "绵阳"},{name: "广元"},{name: "遂宁"},{name: "内江"},{name: "乐山"},{name: "南充"},{name: "眉山"},{name: "宜宾"},{name: "广安"},{name: "达州"},{name: "雅安"},{name: "巴中"},{name: "资阳"},{name: "阿坝"},{name: "甘孜"},{name: "凉山"}]})
Province.create({id: 52,name: "贵州",cities_attributes: [{name: "贵阳"},{name: "六盘水"},{name: "遵义"},{name: "安顺"},{name: "铜仁"},{name: "黔西南"},{name: "毕节"},{name: "黔东南"},{name: "黔南"}]})
Province.create({id: 53,name: "云南",cities_attributes: [{name: "昆明"},{name: "曲靖"},{name: "玉溪"},{name: "保山"},{name: "昭通"},{name: "楚雄"},{name: "红河"},{name: "文山"},{name: "思茅"},{name: "西双版纳"},{name: "大理"},{name: "德宏"},{name: "丽江"},{name: "怒江"},{name: "迪庆"},{name: "临沧"}]})
Province.create({id: 54,name: "西藏",cities_attributes: [{name: "拉萨"},{name: "昌都"},{name: "山南"},{name: "日喀则"},{name: "那曲"},{name: "阿里"},{name: "林芝"}]})
Province.create({id: 61,name: "陕西",cities_attributes: [{name: "西安"},{name: "铜川"},{name: "宝鸡"},{name: "咸阳"},{name: "渭南"},{name: "延安"},{name: "汉中"},{name: "榆林"},{name: "安康"},{name: "商洛"}]})
Province.create({id: 62,name: "甘肃",cities_attributes: [{name: "兰州"},{name: "嘉峪关"},{name: "金昌"},{name: "白银"},{name: "天水"},{name: "武威"},{name: "张掖"},{name: "平凉"},{name: "酒泉"},{name: "庆阳"},{name: "定西"},{name: "陇南"},{name: "临夏"},{name: "甘南"}]})
Province.create({id: 63,name: "青海",cities_attributes: [{name: "西宁"},{name: "海东"},{name: "海北"},{name: "黄南"},{name: "海南"},{name: "果洛"},{name: "玉树"},{name: "海西"}]})
Province.create({id: 64,name: "宁夏",cities_attributes: [{name: "银川"},{name: "石嘴山"},{name: "吴忠"},{name: "固原"}]})
Province.create({id: 65,name: "新疆",cities_attributes: [{name: "乌鲁木齐"},{name: "克拉玛依"},{name: "吐鲁番"},{name: "哈密"},{name: "昌吉"},{name: "博尔塔拉"},{name: "巴音郭楞"},{name: "阿克苏"},{name: "克孜勒苏"},{name: "喀什"},{name: "和田"},{name: "伊犁"},{name: "塔城"},{name: "阿勒泰"}]})
Province.create({id: 71,name: "台湾",cities_attributes: [{name: "台北"},{name: "高雄"},{name: "其他"}]})
Province.create({id: 81,name: "香港",cities_attributes: [{name: "香港"}]})
Province.create({id: 82,name: "澳门",cities_attributes: [{name: "澳门"}]})
Province.create({id: 100,name: "其他",cities_attributes: []})
Province.create({id: 400,name: "海外",cities_attributes: [{name: "美国"},{name: "英国"},{name: "法国"},{name: "俄罗斯"},{name: "加拿大"},{name: "巴西"},{name: "澳大利亚"},{name: "印尼"},{name: "泰国"},{name: "马来西亚"},{name: "新加坡"},{name: "菲律宾"},{name: "越南"},{name: "印度"},{name: "日本"},{name: "其他"}]})
# provinces and cities

a = Doorkeeper::Application.find_or_create_by(uid: ENV['API_UID'],secret: ENV['API_SECRET'],name:'zhaohai',redirect_uri: 'http://zhaohai.test/users/auth/zhaohai/callback')
if a.uid != ENV['API_UID']
  a.update_attribute :uid,ENV['API_UID']
  a.update_attribute :secret,ENV['API_SECRET']
end
