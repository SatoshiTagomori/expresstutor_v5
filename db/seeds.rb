# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#pfs = Array.new
pfs =["北海道","青森県","岩手県","宮城県","秋田県","山形県","福島県","茨城県","栃木県","群馬県","埼玉県","千葉県","東京都","神奈川県","新潟県","富山県","石川県","福井県","山梨県","長野県","岐阜県","静岡県","愛知県","三重県","滋賀県","京都府","大阪府","兵庫県","奈良県","和歌山県","鳥取県","島根県","岡山県","広島県","山口県","徳島県","香川県","愛媛県","高知県","福岡県","佐賀県","長崎県","熊本県","大分県","宮崎県","鹿児島県","沖縄県","海外"]

pfs.each do |pf|
    Pref.create(:name=>pf)
end

gkn =["小一","小二","小三","小四","小五","小六","中一","中二","中三"]
gkn.each do |g|
    Gakunen.create(:name=>g)
end

Product.create(:name=>'ライトコース',:price=>3850,:prod_id=>'prod_J0387oBCjMnbOk',:price_id=>'price_1IONHEHz8Iexb7Ql83LUOz18',:ticket=>5)
Product.create(:name=>'ベーシックコース',:price=>7700,:prod_id=>'prod_J0O6ZYlTrZyG36',:price_id=>'price_1IONKVHz8Iexb7QllGzepVLP',:ticket=>12)
Product.create(:name=>'マスターコース',:price=>10780,:prod_id=>'prod_J0O94lfjzpE3k7',:price_id=>'price_1IONMlHz8Iexb7Ql7ail0rz4',:ticket=>20)