# Manage Overtime
自身及び同僚の
- 残業時間実績
- 困っている事、助けて欲しい事 <br>

を可視化、共有できるアプリです。

## 制作背景
私の職場では、精神疾患を患う職員が少なくなく、長時間労働等の仕事のストレスがその要因と考えられるケースが多いです。 <br>
私はこうした不幸を減らしたいと思っています。 <br>
同僚の残業実態（周期性等）や必要としている手助けを、アプリによって容易に正しく認識できれば、繁忙期の仲間の仕事を早期から手助けする等、様々な改善策実施に繋がると考えています。

## URL
https://intense-atoll-05047.herokuapp.com/ <br>
非ログイン状態の場合は閲覧のみ可能です。ログインすると投稿が可能になります。

## 使用技術
- Ruby 2.6.2
- Rails 5.2.4.2
- MySQL 5.7.28
- Heroku
- RSpec
- Rubocop
- ajax
- Sass, Bootstrap

## 機能一覧
- ユーザー機能
  - 新規登録、ログイン、ログアウト機能
  - マイページ
- 残業記録
  - 登録、編集、削除
  - グラフの表示・表示期間変更
- 依頼事項
  - 登録、編集、削除
- Rspecによる自動テスト機能
  - 単体テスト

## 今後の実装予定
- ゲストユーザーのログイン機能
- 統合テスト
- AWSへのデプロイ
  - 独自ドメイン