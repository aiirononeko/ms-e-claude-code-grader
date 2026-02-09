# Section 1: CS基礎 教材リファレンス

## Section 1-0: オンボーディング

教材なし（オリエンテーション）

---

## Section 1-1: TypeScript

### レッスン内容

- TypeScriptとは
- 型定義とは
- 動的型付けと静的型付け

### 課題

- TypeScript環境構築

### 推奨読み物

- TypeScript Deep Dive 日本語版
- サバイバルTypeScript

---

### TypeScriptの概要

- JavaScript のスーパーセットとして Microsoft が2012年にリリース
- 大規模アプリケーション開発で多くの利点を提供

#### 特徴

- 静的型付けのサポート
- コンパイル時のエラー検出
- Interface や generics などの言語機能

### TypeScript Playground

- Web 上で TypeScript を手軽に試せる実行環境
- typescriptlang.org のトップページから利用可能
- エディタ上部の `RUN` で実行、右側 `Logs` タブで結果確認
- 右側 `JS` タブで生成される JavaScript コードを確認可能

#### サンプルコード

```typescript
function sum(x: number, y: number): number {
  return x + y;
}

const a: number = 10;
const b: number = 20;

console.log(sum(a, b)); // => 30
```

---

### 動的型付けと静的型付け

#### 静的型付け言語

変数や関数などの型を事前に定義し、その型を保持するプログラミング言語。

例: C/C++, Java, Golang, TypeScript

#### 動的型付け言語

プログラムの実行中に、動的に型に対応することが可能なプログラミング言語。

例: Ruby, PHP, JavaScript, Python

#### 動的型付け言語の注意点

特定の型を想定した機能に他の型の値を渡すと予期しない動作をする可能性がある。

```javascript
function add(a, b) {
    return a + b;
}

console.log(add(1, 2));     // => 3
console.log(add("1", "2")); // => "12"（文字列結合になる）
```

---

### 型定義

#### プリミティブ型

| 型 | 説明 |
|---|------|
| `boolean` | 真偽値（`true` / `false`） |
| `number` | 数値（整数・浮動小数点数） |
| `string` | 文字列（`' '`, `" "`, `` ` ` `` で囲む） |
| `bigint` | 大きな整数（ES2020〜、末尾に `n`） |
| `null` | 値が存在しないことを明示 |
| `undefined` | 値が未定義 |

```typescript
let num: number;
num = 2022;
num = '2022'; // Error

let str: string;
str = '2022';
str = 2022; // Error

let bool: boolean;
bool = true;
bool = 'true'; // Error
```

#### リテラル型

特定の値のみを許可する型。

- 厳密な値の制約が可能
- コードの可読性と保守性の向上
- ユニオン型との組み合わせで列挙型のような機能を実現

```typescript
type greeting = 'Hello' | 'こんにちは' | '你好'

const sayHello = (greeting: greeting) => {
  console.log(greeting)
}

sayHello('Hello')    // OK
sayHello('こんばんは') // Error: Argument of type '"こんばんは"' is not assignable to parameter of type 'greeting'.
```

#### 配列型

同じ型の要素を持つ配列を定義。2種類の記法がある（プロジェクトで統一する）。

```typescript
// Type[] 記法
let array: string[];
array = ["ms", "engineer", "student"];
array.push(123);         // Error
array.push("instructor"); // OK

// Array<T> 記法
let array: Array<string>;
array = ["ms", "engineer", "student"];
array.push(123);         // Error
array.push("instructor"); // OK
```

#### オブジェクト型

複数のプロパティを持つデータ構造を定義。

```typescript
type Email = `${string}@ms-engineer.jp`

type User = {
    name: string
    age: number
    email: Email
    isRemotework: boolean
    department?: string | null
}

const hanako: User = {
    name: 'hanako',
    age: 30,
    email: `hanako@ms-engineer.jp`,
    isRemotework: true,
    department: '営業部'
}
```

参考: interface と type の違い（サバイバルTypeScript参照）

#### 関数の型定義

```typescript
function checkCookie(flg: boolean): string {
    if(flg){
      return "I have cookie";
    }else{
        return "I don't have cookie";
    }
}

checkCookie()       // Error: 引数不足
checkCookie('true') // Error: 型不一致
checkCookie(true)   // OK
```

---

### 環境構築

#### 必要なツール

- Node.js（`node -v`, `npm -v` で確認）
- TypeScript（`npm install -g typescript ts-node`、`tsc -v` で確認）

#### Windows固有の注意

- OneDrive 配下では動かないケースが多い
- Cドライブ直下にフォルダを作成推奨（例: `C:\dev\`）
- スクリプト実行ポリシーエラーが出る場合は PowerShell の実行ポリシー変更が必要

#### プロジェクトセットアップ手順

1. ディレクトリ作成
2. `npm init -y` で `package.json` 生成
3. `npm install --save-dev typescript` でプロジェクト固有の TypeScript インストール
4. `npx tsc --init` で `tsconfig.json` 生成

#### 動作確認

1. `index.ts` を作成（sum関数のサンプルコード）
2. `tsc index.ts` でコンパイル → `index.js` が生成される（トランスパイル）
3. `node index.js` で実行 → `30` と出力されればOK

#### ts-node による直接実行

- `tsc` はコンパイラであり TypeScript を直接実行できない
- 開発中は `ts-node` で ts ファイルを直接実行可能
- `ts-node your_script.ts` で実行

---

### 課題（Must）

#### 1. 数値の配列から最大値を取得する関数

- 10個以上の要素を持つ数値型の配列を定義
- 数値型の配列を引数に取り、最大値を返す関数を定義

#### 2. FizzBuzz 関数

- 数値型を引数に取り、以下を返す関数を定義:
  - 3の倍数 → `Fizz`
  - 5の倍数 → `Buzz`
  - 3と5の倍数 → `FizzBuzz`
  - それ以外 → 元の数値
- 1〜100までの返り値を順番にコンソール出力

#### 3. 逆さ文字列

- 文字列を引数に取り、逆順にして返す関数を作成
- `baseball` → `llabesab` を確認

#### 4. 文字列分割

- 「任意の文章」と「区切り文字」を引数に取り、区切った配列を返す関数を作成
- `'apple,orange,strawberry'` と `,` → `['apple', 'orange', 'strawberry']` を確認

### 課題（Advanced）

#### データ集計

提供されたディレクトリ構造・ソースコードをベースに実装。

##### ディレクトリ構成

```
│  index.ts
│  tsconfig.json
├─data/
│   index.ts
├─models/
│   category.ts
│   transaction.ts
│   user.ts
└─services/
    index.ts
    util.ts
```

##### 要件

1. 「Ariel」の「2024年01月」の支出の合計額をコンソールに出力
2. 「Ariel」の「2024年01月」の支出と収入の差額をコンソールに出力
3. 「Ariel」の「2024年01月」の食費のリストをコンソールに出力

##### 提供コード（models）

**models/user.ts**
```typescript
type User = {
    id: number
    name: string
}
export type { User }
```

**models/category.ts**
```typescript
type CategoryType = '住居費' | '日用品' | '食費' | '交通費' | '交際費' | '趣味・娯楽' | '医療費' | '給与'
type Category = {
    id: number
    name: CategoryType
}
export type { CategoryType, Category }
```

**models/transaction.ts**
```typescript
type TransactionType = '収入' | '支出'
type Transaction = {
    id: number
    amount: number
    type: TransactionType
    year: number
    month: number
    day: number
    user_id: number
    category_id: number
}
export type { TransactionType, Transaction }
```

##### 提供コード（data）

**data/index.ts** — ユーザー2名、カテゴリ8種、トランザクション12件のサンプルデータ。

主なデータ:
- Ariel (id:1), Belle (id:2)
- カテゴリ: 住居費(1), 日用品(2), 食費(3), 交通費(4), 交際費(5), 趣味・娯楽(6), 医療費(7), 給与(8)
- Ariel の1月トランザクション: 支出(住居費75000, 食費1500/2000/500, 趣味・娯楽6000, 医療費3500), 収入(給与400000)

##### 提供コード（services）

**services/util.ts** — 変更不可。以下のユーティリティ関数を提供:
- `getAmount`: Transaction配列のamount合計を返す
- `filterTransactionsByUser`: user_idでフィルタ
- `filterTransactionsByCategory`: category_idでフィルタ
- `filterTransactionByMonth`: monthでフィルタ
- `filterTransactionByType`: type（収入/支出）でフィルタ

**services/index.ts** — 受講生が実装する3関数:
- `getUserExpense`: ユーザの特定月の支出合計を返す
- `calcDifference`: ユーザの特定月の支出と収入の差額を返す
- `getTransactionsByCategory`: ユーザの特定月・特定カテゴリの支出リストを返す

**index.ts** — メインファイル（提供済み）。上記3関数を呼び出して結果を出力。

##### 実行方法

```bash
ts-node index.ts
```

---

### 課題提出

- GitHub organization 内に `name_section_1_1` リポジトリを作成
- Discord の `#review-request` チャンネルで `@help_bc` をつけてリポジトリURLを共有
- Section 1〜2 では Section 2-4 以外、提出は任意

---

## Section 1-2: Web基礎・GitHub開発プロセス

### レッスン内容

- インターネットの仕組み
- HTTPとは
- ブラウザの役割と仕組み
- Webページが表示される仕組み
- Webアプリケーションが動作する仕組み
- GitHubを活用した開発プロセス

### 課題

- Googleのアーキテクチャ図を書く
- Amazon（EC）のアーキテクチャ図を書く
- Git/GitHub に関する動画視聴

### 参考URL

- [MDN - インターネットはどのように動くのか](https://developer.mozilla.org/ja/docs/Learn/Common_questions/How_does_the_Internet_work)
- [ブラウザの仕組み](https://www.html5rocks.com/ja/tutorials/internals/howbrowserswork/)
- [ブラウザ](https://speakerdeck.com/recruitengineers/browser-b45d3a59-af2b-449c-992e-fd7563745f80)
- 【基礎からわかる！】Webアプリケーションの仕組み（Udemy）

---

### インターネットの仕組み

#### 小さなネットワーク（家庭やオフィスなど）

- 複数台の端末を相互に通信させるには、物理的なLANケーブルや無線（Wi-FiやBluetoothなど）で接続が必要
- 各コンピュータはルーターと呼ばれる機器に接続する
- 各コンピュータはルーターに対して通信先を要求し、ルーターが必要な経路に通信を流す

#### ネットワークのネットワーク

- ルーター同士を接続することで、ネットワークは無限に拡張可能
- ただし個人のルーターを直接世界に繋ぐことは現実的ではない

#### ISP事業者（インターネット・サービス・プロバイダー）

- 各国のISP事業者同士のネットワークによってインターネットが形成されている

---

### HTTPとは

#### Hypertext Transfer Protocol (HTTP)

- HTMLなどのハイパーメディア文書を転送するためのアプリケーション層プロトコル
- プロトコルとは、コンピューター同士の通信をする際の手順や規格のこと

```
http://ms-engineer.jp
（httpというプロトコルで「ms-engineer.jp」と通信しますという宣言）
```

#### ステートレス

- HTTPの通信は、クライアント側・サーバー側に状態の保持を要求しない

#### セッションとCookie

- ステートレスなHTTP通信で状態を保持する仕組み:
  - サーバー側で情報を「セッション」という仕組みで保持する
  - サーバーはクライアント側に「Cookie」を渡して次回以降の識別に使う
  - クライアントは受け取った「Cookie」をサーバーに渡して、サーバーがどの「セッション」情報を使えばいいのか分かるようにする

---

### ブラウザの役割と仕組み

- ブラウザとは: Webサーバーとの通信を適切に行い、受け取ったコンテンツをユーザーに表示するアプリケーション

---

### Webページが表示される仕組み

1. URL入力・リンククリックなどブラウザに対してユーザがページ表示を要求
2. ブラウザがドメインを解釈し、DNSサーバにIPアドレスを問い合わせる
3. 取得したIPアドレスにコンテンツを要求
4. Webサーバは要求に応じたコンテンツをクライアントに提供
5. ブラウザがコンテンツを解釈して画面に表示

---

### Webアプリケーションが動作する仕組み

- ブラウザが通信するアプリケーションは、様々な機能がレイヤーとして構成されている
- どのような構成があるのか調べることが学習ポイント

---

### GitHub を活用した開発プロセス

#### 開発フロー

1. **リポジトリのクローン**: `git clone [リポジトリURL]`
2. **ブランチの作成**: `git checkout -b [新しいブランチ名]`（`feature/xxx` のような命名が好ましい）
3. **コードの編集**: 編集後 `git add .` でステージング
4. **コミット**: `git commit -m "コミットメッセージ"`
5. **リモートリポジトリへのプッシュ**: `git push origin [新しいブランチ名]`
6. **プルリクエストの作成**: GitHub上で変更内容や意図を明確に記述
7. **コードレビュー**: 他の開発者がレビューしコメント（個人開発時は不要）
8. **プルリクエストのマージ**: レビュー完了後、マスターブランチにマージ
9. **ブランチの削除**: `git branch -d [ブランチ名]`
10. **ローカルとリモートの同期**: `git pull origin main` → `git push origin --delete [ブランチ名]`

#### 確認コマンド

| 用途 | コマンド |
|------|---------|
| ブランチ確認 | `git branch` |
| ステージング確認 | `git status` |
| コミット履歴確認 | `git log` |

---

### Git を使うときの注意点

#### サブモジュール

- git では入れ子構造でバージョン管理用のリポジトリを管理するサブモジュールという考え方がある
- モジュール管理が複雑化するため、BC中はサブモジュールを使用せずに開発を行う

#### 作業ディレクトリ

- Desktop、システムが利用するフォルダ、クラウドと同期されるフォルダなど特殊な役割を持つディレクトリは避けて開発する

---

### 課題（Must）

#### ハンズオン: Googleのアーキテクチャ図

- 処理や通信の流れを順番に書き出す

#### Amazon（EC）のアーキテクチャ図

- ブラウザ、Webサーバー、アプリケーションサーバー、DBサーバーを要素に入れる
- 特定の機能（カートに入れる、検索など）について、処理や通信の流れを順番に書き出す

#### Git/GitHub 動画視聴

- 「システム開発プロジェクト応用第一 第5,6回 Gitによるバージョン管理」
- 「システム開発プロジェクト応用第一 第8,9回 GitHub & Pull Request」

---

### 課題提出

- ワーク1（アーキテクチャ図）はDiscordにアップロードしてレビュー依頼
- ワーク2（動画視聴）は提出・レビュー不要

---

## Section 1-3: CS基礎（コンピュータシステム・パフォーマンス）

### レッスン内容

- コンピュータレイヤー
  - 物理（CPU/メモリ/記憶容量）
  - OS
  - ミドルウェア/アプリケーション
- アプリケーションのパフォーマンス
  - 計算量
  - I/O
  - キャッシュ

### 課題

- コンピュータシステム記述問題（Q1〜Q16）
- コマンド操作練習

### 参考URL

- [IPA 情報処理技術者試験 シラバス](https://warp.ndl.go.jp/info:ndljp/pid/12446699/www.ipa.go.jp/files/000055981.pdf)

---

### コンピューターシステムのレイヤー

コンピューターシステムは、物理的なハードウェアレイヤ・オペレーティングシステム(OS)・middleware 及びアプリケーションによって構成される。

---

### ハードウェア層

世の中のアプリケーションやシステムは、すべてハードウェア上で動作している。

#### CPU

- 中央演算装置と呼ばれ、コンピュータシステムの中でプログラムを解釈して制御・演算を担当する

#### メモリー

- コンピュータシステム上でデータの一時置き場として機能する
- プログラムの展開、データの保持など、動かすアプリケーションが増えるほどメモリ容量も必要になる

#### 記憶装置

- コンピューターシステムのデータやプログラムの保存・記憶を行う装置

---

### OS層

- OSはコンピューターシステムの制御やミドルウェア・アプリケーションへの機能の提供をする
- ユーザーがコンピューターを簡単に操作できるようにする役割を持つ

主な機能:
- ファイルシステム
- プロセス管理
- ネットワーク
- ユーザーインターフェース

#### 代表的なOS

- Windows系
- Linux系
- macOS
- Android系
- iOS

---

### Middleware（ミドルウェア）

OSよりも専門的な機能を複数のアプリケーションから利用できるような形で提供しているソフトウェア。

例:
- Webサーバー
- 言語の実行環境
- データベース管理システム
- クラスタ管理システム
- 監視系システム

---

### アプリケーション

特定の機能や目的を達成するために作られたソフトウェア。

- **ネイティブアプリ**: スマホにインストールして使うアプリ
- **Webアプリ**: ブラウザでアクセスして使うアプリ

※YouTubeのように両方の形態を持つアプリも存在する。

---

### 計算量

コンピュータサイエンスにおいて、計算量とはアルゴリズムやデータ構造が問題を解決するために使用する時間、空間などの計算資源の様々な側面を指す。

#### 計算ステップ数

アルゴリズムが入力に対して要する基本的な計算ステップの数のこと。通常、O(n)、O(n^2)、O(log n)などのビッグO表記で表される（nは入力の大きさ）。

- O → Order（桁）

#### O(n) — 線形時間

配列の合計値を算出する関数の例:

```javascript
function sumArray(arr) {
  let sum = 0;
  for (let i = 0; i < arr.length; i++) {
    sum += arr[i];
  }
  return sum;
}
```

- 引数の配列の長さ `n` の回数分計算が行われる
- 計算ステップ数は入力 `n` に対して線形に大きくなるため `O(n)`
- 投入するデータ量に比例して処理時間がかかる

#### O(n^2) — 二乗時間

バブルソートの例:

```javascript
function bubbleSort(arr) {
  let len = arr.length;
  for (let i = 0; i < len; i++) {
    for (let j = 0; j < (len - 1) - i; j++) {
      if (arr[j] > arr[j + 1]) {
        let temp = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = temp;
      }
    }
  }
  return arr;
}
```

- `n^2 - n` 回の計算が行われる
- 計算量の算出では概算を知るため、一般的に一番大きい乗数以外は無視し、係数も省略する
- バブルソートの計算量は `O(n^2)`
- 投入するデータ量の二乗で処理量が増加する

#### O(log n) — 対数時間

バイナリサーチの例:

```javascript
function binarySearch(arr, target) {
  let left = 0;
  let right = arr.length - 1;

  while (left <= right) {
    let middle = Math.floor((left + right) / 2);

    if (arr[middle] === target) {
      return middle;
    } else if (arr[middle] < target) {
      left = middle + 1;
    } else {
      right = middle - 1;
    }
  }

  return -1;
}
```

- 配列の中央の要素を調べ、目的の値との大小を比較して探索範囲を半分に絞り込む
- このプロセスを繰り返し、目的の値が見つかるか探索範囲がなくなるまで続ける
- 探索範囲が指数関数的に縮小していくため `O(log n)`

---

### I/O とパフォーマンス

I: Input（入力）、O: Output（出力）

ソフトウェアにおけるパフォーマンスは、アルゴリズムの効率の他にもデータの転送にかかるI/Oが大きなウェイトを占める。基本的に処理を行うCPUからの距離が遠い場合や、読み書き速度の遅いハードウェアへのアクセスほど、パフォーマンスに負の影響を与える。

#### メモリ（RAM）

- CPUによる直接アクセスが可能で、高速なデータの読み書きが行える
- ディスクやネットワークに比べて非常に高速
- 計算中のリソースや高頻度でアクセスするリソースを配置することが有効
- ただしディスクよりも容量が限られており、コストが高い

#### ディスク（SSD, HDD）

- 大量のデータを永続的に保存するためのハードウェア
- ファイルアクセスやローカルのRDBMSへのアクセスなどがディスクI/Oにあたる
- メモリよりも遅いため、アプリケーションのボトルネックになる可能性がある

#### ネットワーク

- WebAPIやDBコネクションなど、コンピュータ間でネットワークを利用して転送されるリソース
- ネットワークの速度は帯域幅や遅延、プロトコルなどによって決まる
- メモリやディスクへのアクセスに比べてさらに遅くなることが一般的

---

### キャッシュ

何度も利用する計算結果やアクセス頻度の高いリソースをキャッシュとして保持しておくことで、計算を省略したり非効率なI/Oを削減できる。

キャッシュの活用例:
- ブラウザ側でのキャッシュ（Webページのリロード時など）
- サーバー側でのキャッシュ

#### メリット

- アプリケーションサーバの負荷低減（PCのリソースの節約）
- ボトルネックの解消によるパフォーマンス向上（動作が快適になる）

#### デメリット

- アーキテクチャの複雑化
  - セキュリティ・個人情報のリスク
  - 古いデータを返すリスク
  - キャッシュ原因の不具合が追いづらい
  - 設計と運用が難しい
  - メモリやストレージを消費
- 一般的なキャッシュはメモリ上に保持するため揮発性がある
- キャッシュミスの時に逆に重くなる

#### インメモリキャッシュ

- HDDやSSDなどの記憶装置へのアクセスに比べて、メモリアクセスは高速
- リソースをメモリ上に展開しておくことで高速に提供可能
- [Redis](https://aws.amazon.com/jp/redis/) というOSSが一般的に使われている
- メモリを高頻度で利用するキャッシュなどのシステムは、長期間の運用でメモリフラグメンテーション（断片化）が発生することがある

---

### 課題（Must）

#### コンピュータシステム記述問題

自分の言葉で端的に回答する。テキストファイル等に回答を記述して提出。

```
Q1: BIOSとはなんですか？
Q2: OSに対するBIOSの役割を説明してください。
Q3: カーネルとはなんですか？
Q4: シェルとはなんですか？
Q5: CPUのクロック性能とはなんですか？
Q6: CPUのクロック性能が高いと何が嬉しいですか？
Q7: CPUのコア数とはなんですか？
Q8: CPUのコア数が多いと何が嬉しいですか？
Q9: IntelやAMDのCPUでは動作するアプリが、M1 Macなどでは動かない場合があるのはなぜですか？
Q10: メモリ容量が大きいと何が嬉しいですか？
Q11: メモリリークとは何ですか？
Q12: SSDとHDDの違いを説明してください。
Q13: SSDへのデータ読み書きとメモリへのデータ読み書きはどちらが高速ですか？
Q14: 世の中にはSAP HANAやApache Sparkのようなインメモリシステムがあります。通常のアプリケーションと比べて何が優れていますか？
Q15: ネイティブアプリとWebアプリの違いを説明してください。
Q16: Webアプリがネイティブアプリに対して優れている点・不便な点はそれぞれなんですか？
```

#### コマンド練習問題

WindowsユーザーはWSL上、macユーザーはターミナル上で実施。提出不要。

1. シェルのバージョンを確認
2. "hello_world" を表示
3. "hello_world" を格納した sample.txt を作成
4. sample.txt の中身を表示
5. sample.txt に "2nd_text" を追記
6. sample.txt 内の "2" が含まれる行のみ表示
7. sample.txt のファイル名を hoge.txt に変更
8. fuga ディレクトリを作成
9. hoge.txt を fuga ディレクトリの下にコピー
10. fuga ディレクトリの下の hoge.txt に "3rd_text" を追記
11. 現在のディレクトリの hoge.txt の中身を表示
12. fuga ディレクトリに移動
13. 現在のディレクトリの hoge.txt の中身を表示
14. 現在の日時を yyyy-MM-dd 形式で表示
15. 14の形式で表示したテキストを log.txt に書き込み

---

### 課題提出

- コンピュータシステムの課題は `.txt` もしくは `.md` ファイルを作成してGitHubにpush
- コマンド練習問題は提出不要

---

## Section 1-4: 仮想化・Docker

### レッスン内容

- 仮想化とは
- 仮想化の種類
- コンテナ
- Docker

### 課題

- nginxコンテナを立ち上げて疎通確認
- ポートフォリオサイト作成（nginxで表示）

---

### 仮想化とは

1つのマシンを分割して複数のマシンがあるように振舞ったり、マシン上に隔離された空間を作り出す技術。

- 以前は環境ごとに別々のPCやサーバーを用意していた
- それぞれ別のサーバを、その上にあるOSとアプリはそのままにしてまとめ、1つの物理サーバ上で複数のアプリを動作できるようにするのが仮想化

※複数台のマシンを1つのマシンのように見せる仮想化技術もあるが、このレッスンでは取り扱わない。

#### 仮想化のメリット

- コスト削減（リソースの無駄を排除できる）
- 安価なサーバーで対応できる
- 障害に強くなる
- 古いシステムを延命できる

#### 仮想化のデメリット

- 小規模環境ではコストが割高
- 高速なI/Oを必要とするシステムでは、物理サーバーの方がパフォーマンスが良い
- 仮想環境を管理するための知識・技術が必要
- 物理ハードウェア故障の影響範囲が大きくなる

---

### 仮想化の種類

- ホストOS型
- ハイパーバイザー型
- コンテナ型

#### コンテナ型のメリット

- リソースの有効活用
- 処理速度の向上
- 軽量なので起動が高速
- 異なる環境であっても一貫された動作が保証されている
- 開発・運用コストの削減
- 環境構築が簡単

---

### コンテナ

アプリ動作環境を仮想化する技術のひとつ。

- 従来は1つの仮想環境の中にOSから作っていたが、OSは同じでいい場合が多く、リソースが無駄になっていたり数十GBのサイズが必要だった
- コンテナではOS周りの環境は共通して使用し、アプリが使うライブラリやミドルウェアなどだけ別々で管理する
- 仮想化ソフトウェアの代わりにコンテナを動かすエンジンをOSの上にのせる → **Docker**

---

### Docker

「コンテナ型」の仮想化技術を実現するソフトウェアプラットフォーム。

#### Dockerの仕組み

| 概念 | 説明 |
|------|------|
| **Dockerエンジン** | Dockerそのもの。MacやWindowsにDockerをインストールすることで利用できる |
| **Dockerコンテナ** | Dockerエンジンの上で動いている仮想環境。ホストOSのカーネルを各コンテナが共有して動く |
| **Dockerイメージ** | Dockerコンテナを作るための指示書。このイメージを元にコンテナが作成される。元になるイメージにレイヤを重ねることで新たなイメージを作る |
| **Dockerレジストリ** | Dockerイメージを保管している場所（DockerHubなど） |

#### Dockerを使うメリット

- 軽量かつスピーディーに開発できる
- 簡単に環境構築ができる
- 環境に依存せずに動作する

#### 関連リンク

- [Docker](https://www.docker.com/) — プログラムの実行環境を管理するシステム
- [DockerHub](https://hub.docker.com/) — プログラムの実行環境を共有する仕組み
- [Docker Compose](https://docs.docker.jp/compose/index.html) — 複数のコンテナアプリケーションを管理する仕組み

---

### 課題（Must）

#### nginxコンテナの立ち上げと疎通確認

1. Docker Desktopをインストール
   - [Windows版](https://docs.docker.jp/docker-for-windows/install.html)
   - [Mac版](https://docs.docker.jp/docker-for-mac/install.html)
2. nginxのコンテナを立ち上げる
3. コンテナのプロセスを確認する
4. ブラウザから `http://localhost/` にアクセスしてnginxのウェルカムページが表示されることを確認

#### ポートフォリオサイト作成

- 自分のポートフォリオになるようなWebページを作成してnginxを通して表示させる
- 含める要素の例: プロフィール、プロフィール画像、仕事の経歴など

---

### 課題提出

- 提出は任意
- 提出する場合: Dockerでnginxのコンテナを立ち上げるための手順書、nginxが立ち上がった時のスクリーンショット、ポートフォリオのHTML/CSSなどをGitHubにpush

---

## Section 1-5: Linux/Unix・シェルスクリプト

### レッスン内容

- OS
  - OSの種類
  - Linux/Unixの種類
- OS操作（ファイル/ディレクトリ）
- シェルスクリプト

### 課題

- シェルスクリプト練習問題
- Linux実践問題

### 参考URL

- [Linuxディストリビューション（Wikipedia）](https://ja.wikipedia.org/wiki/Linux%E3%83%87%E3%82%A3%E3%82%B9%E3%83%88%E3%83%AA%E3%83%93%E3%83%A5%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3)

---

### Linux/Unixの種類

- LinuxはOSの総称であり、オープンソースなので様々な派生OS（ディストリビューション）が作成された
- ディストリビューションごとに機能や使用感が異なる

---

### OS操作（ハンズオン）

#### Dockerを利用してUbuntu環境を構築

```bash
# ubuntu 24.04 の docker image を取得
docker image pull ubuntu:24.04

# container を実行
docker container run -it -d --name ubuntu2404 ubuntu:24.04

# コンテナにアクセス
docker container exec -it ubuntu2404 /bin/bash
```

#### 基本コマンド

| コマンド | 説明 |
|---------|------|
| `pwd` | 現在のディレクトリを表示 |
| `ls` | ディレクトリ内のファイルとディレクトリの一覧を表示 |
| `ls -l` | より詳しくファイルとディレクトリ情報を表示 |

#### テキストエディタ（vim）のインストール

```bash
apt-get update
apt-get install vim
```

```bash
# テキストファイルを作成
vim hoge.txt
```

---

### ShellScript

シェル上で実行するコマンドなどがまとまったスクリプトファイル。

#### サンプルスクリプト

```bash
#!/bin/bash

ls -l ./

touch newfile

ls -l ./
```

実行方法:

```bash
./sample.sh
```

---

### 課題（Must）

#### 1. シェルスクリプト練習問題

- 1-1. 現在の日付と時間を表示するスクリプトを作成
- 1-2. 数値を入力すると奇数か偶数か判定する対話型のスクリプトを作成

#### 2. Linux実践問題

Docker環境を構築して実施する（提供されるDockerfileとREADMEを使用）。

- 2-1. `/home` ディレクトリ以下5階層の `.sh` 拡張子のファイルを検索
- 2-2. `/home` ディレクトリ以下5階層の "Ms.Engineer" という文字列が含まれるファイルを検索
- 2-3. 引数に文字列を指定すると、その文字を含むファイルを検索するスクリプトを作成
- 2-4. `/practice` ディレクトリを作成し、ファイル名が現在日時のファイルを `/practice` 以下に生成するスクリプトを作成（例: `20220721_1322.txt`）
- 2-5. cronを利用して5分に一回、ファイル名が現在日時のファイルを `/practice/` 以下に生成するスクリプトを作成

### 課題（Advanced）

- 「あったら便利だな」というシェルスクリプトを考えて作成する

---

### 課題提出

- シェルスクリプト練習問題は `.sh` ファイルを作成してGitHubにpush
- Linux実践問題は基本的に提出不要（コマンドレビュー希望の場合は打ったコマンドと結果を `.txt` または `.md` にまとめて提出可）
