# Section 4: Backend + Express 教材リファレンス

## Section 4-1: API サーバ・REST・Express.js

### レッスン内容

- クライアントとサーバ
- APIサーバとは
- REST
- Express.js

### 課題

- 家計簿アプリに必要なAPIをREST風に設計する
- 設計したAPIをExpress.jsで実装する

### 参考URL

- [The Twelve-Factor App（日本語訳）](https://12factor.net/ja/backing-services)
- [Web API 設計のベストプラクティス - Azure](https://learn.microsoft.com/ja-jp/azure/architecture/best-practices/api-design)
- [RESTful API の設計 - IBM](https://www.ibm.com/docs/ja/zos-connect/zosconnect/3.0?topic=apis-designing-restful)
- [GraphQL](https://graphql.org/)
- [GraphQLを導入する時に考えておいたほうが良いこと｜メルカリ](https://engineering.mercari.com/blog/entry/20220303-concerns-with-using-graphql/)
- [Express 4.x - APIリファレンス](https://expressjs.com/ja/4x/api.html)
- [Express でのルーティング](https://expressjs.com/ja/guide/routing.html)
- [webアプリ開発における環境変数まわりのベストプラクティス](https://zenn.dev/dove/articles/5fd7926e7da949)

---

### クライアントサイドとサーバーサイド

#### クライアントサイドの特徴

- ブラウザ（ユーザのコンピュータ）で動くアプリケーション
- サーバ負荷が低い（クライアントのPCリソースを使う）
- プログラムやデータがユーザに見られる

#### サーバーサイドの特徴

- サーバ上で動作するアプリケーション
- 同時に複数人に機能を提供するため高負荷になりやすい
- 低スペックなクライアントでも影響なく機能を提供できる
- プログラムや重要なデータがユーザに見えない

---

### APIサーバとは

#### APIとは

APIとは「Application Programming Interface」の略。アプリケーションの機能を外部に提供したり、外部アプリケーションの機能を利用するためにAPIを利用する。

※Next.jsにもAPI機能があり、さらに外部のAPIサーバを利用することもある。

#### APIを使うメリット

- 拡張性の高いシステムを作ることができる（認証サーバ・決済サーバなど、サーバごとに専門の機能のみを担当することも可能）
- データベースや各種リソースへのアクセス処理を隠蔽できる
- APIを提供しているサービスを利用すると、高度な機能やサービスをスピーディーにシステムに組み込める

---

### API設計

APIは文字通りインターフェースだが、共通のルールは無いためシステムに合わせて設計する必要がある。特殊な理由がない限りは、世間一般で利用されているAPIの設計方針に沿って開発するケースが多い。

#### REST

REST API（レストエーピーアイ）とは、リソース指向のURL設計を指す。各リソースは単一のURLを持ち、HTTPメソッドを指定することでリソースを操作する。

**特徴:**

- **リソース指向**: 各リソースをURLで表現するため、対象のデータが直感的に理解しやすい
  - 例: `/api/v1/users/13020`
  - `/api/v1/products` → GET（一覧取得）, POST（作成）
  - `/api/v1/products/1234` → GET（個別取得）, PUT（更新）, DELETE（削除）
- **ステートレス**: リソースへの操作をHTTPメソッドとURLでのみ表現するため、前後のリクエストと基本的に干渉しない。キャッシュが可能であったり、サーバの水平スケールが容易になる

#### GraphQL

GraphQL（グラフキューエル）とは、API向けに作られたクエリ言語（Query Language）およびその実装（ランタイム）のこと。

**メリット:**
- 必要なデータのみを取得できる
- 単一のAPIエンドポイントからのデータ取得
- レスポンスが早い
- 型定義されている

#### REST API と GraphQL の比較

|  | REST | GraphQL |
|--|------|---------|
| エンドポイント | 複数 | 単一 |
| データ取得 | オーバーフェッチ、アンダーフェッチ | 必要なデータのみを取得 |
| 型付け | JSON | スキーマ |
| データ操作 | GET/POST/PUT/DELETE | Query/Mutation |

#### リクエスト例の比較

**REST API:**

```
GET /services
```

```json
{
  "services": [
    { "id": "1", "name": "test", "price": 1000, "category_id": 1 }
  ]
}
```

**GraphQL:**

```graphql
query {
  services {
    id
    price
    category_id
  }
}
```

```json
{
  "data": {
    "services": [
      { "id": "1", "price": 1000, "category_id": 1 }
    ]
  }
}
```

---

### JSON

JSONとは「JavaScript Object Notation」の略で、JavaScriptオブジェクトの構文に従ったテキストベースのデータ形式。

```json
{
  "name": "Tanaka Hanako",
  "age": 25,
  "skills": ["JavaScript", "React", "Vue"]
}
```

---

### Node.js

Chrome V8 JavaScriptエンジンをベースに構築されたJavaScript実行環境。サーバーサイドでの実行を想定しており、ブラウザベースの実行環境とは異なる様々な機能を提供する。

#### サーバーサイドでの実行に適した機能

- ネットワーク、ファイルシステム、子プロセスの制御などのシステムリソースにアクセス可能
- サーバサイドアプリケーションの機能を実現するための組み込みモジュールを提供
- ※クライアントサイドで提供されているDOM操作やブラウザAPIなどの機能は利用できない

---

### フレームワーク

Webアプリケーションのフレームワークとは、非機能要件やセキュリティ対策などを内包しつつ、汎用的な機能やツールを提供する開発支援ソフトウェア。

#### 多くのフレームワークで提供される機能

- ルーティング機能
- ミドルウェア機能
- データソースへのアクセス機能
- バリデーションやセキュリティに関する機能
- 認証を支援する機能
- テスト支援機能

※フレームワーク自体にも設計思想があり、オールインワンを目指す多機能なものや、柔軟にカスタマイズ可能なミニマルなものなど、それぞれ得意領域がある。

---

### Express.js

ExpressはNode.jsのWebアプリケーションフレームワーク。

#### セットアップ手順

```bash
mkdir api && cd api
npm init -y
npm install express
npm install -D typescript ts-node @types/node @types/express
tsc --init
mkdir src
```

**tsconfig.json:**

```json
{
  "compilerOptions": {
    "target": "es6",
    "module": "commonjs",
    "rootDir": "./src",
    "outDir": "./build",
    "esModuleInterop": true,
    "strict": true,
    "skipLibCheck": true
  },
  "include": ["src/**/*"]
}
```

**package.json の scripts:**

```json
"scripts": {
  "dev": "ts-node src/app.ts",
  "build": "tsc",
  "start": "node build/app.js"
}
```

**src/app.ts:**

```tsx
import express from 'express';
import userRouter from './router/user';

const app = express();
const port = 4000;

app.use('/user', userRouter);

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
```

**src/router/user.ts:**

```tsx
import { Router } from "express";

const router = Router();

router.get("/", (req, res) => {
  res.send("User router works!");
});

export default router;
```

起動:

```bash
npm run dev
```

- `http://localhost:4000/` → 「Hello World!」
- `http://localhost:4000/user` → 「User router works!」

#### Docker設定

**Dockerfile（api直下）:**

```dockerfile
FROM node:lts
WORKDIR /usr/src/app
COPY . .
RUN npm install
EXPOSE 4000
CMD ["npm", "run", "dev"]
```

**compose.yaml（apiと同じ階層）:**

```yaml
services:
  app:
    build: ./api
    tty: true
    ports:
      - 4000:4000
    volumes:
      - ./api:/usr/src/app
```

```bash
docker compose up -d
```

---

### 環境変数

アプリケーションのコードを書き替えずに、動作させる環境ごとに異なる設定をする仕組み。

**.env ファイル:**

```
# コメント行
KEY=VALUE
PORT=3000
```

**コードからの利用:**

```jsx
console.log(process.env.KEY);
```

※Windowsでの開発では `dotenv` ライブラリを利用してファイルを読み込むことも多い。

---

### 課題（Must）

#### 1. 家計簿アプリに必要なAPIをREST風に設計

- 設計書はマークダウンで記載する
- APIが提供するリソースの一覧があること
- エンドポイントの一覧があること
- HTTPメソッドごとに設計があること
- リクエストとレスポンスのデータ形式が決まっていること

※厳密にRESTに準拠する必要はない。

#### 2. 設計したAPIをExpress.jsで実装

- TypeScriptを利用すること
- 設計書の通りにリクエストを受け付けてレスポンスを返すようにする
- Next.jsとは違うポートで立ち上がるように設定する
- リソースごとにルーターを作成してアプリケーションと紐づける
- 不正なデータ形式でリクエストが来た場合はエラーを返す
- クライアントはSection 3で作成したNext.jsのサーバー側を修正して使用する
- データの取得・登録などはダミーでよい（Section 4の中盤以降でDB接続処理を学ぶ）

---

### 課題提出

- PRを作成して提出（mainブランチから `feature/express` ブランチを作成、マージはしない）
- Section 4-5の課題提出タイミングまでに提出

---

## Section 4-2: ログ・デバッグ・エラー処理

### レッスン内容

- ログ
- デバッグ
- エラー処理

### 課題

- Express.jsで作ったAPIサーバにログを仕込む
- コンテナ上のアプリをデバッグできるようにする
- バリデーションを実装する

### 参考URL

- [運用出来るWebアプリケーションの作り方](https://zenn.dev/koduki/articles/7eb90f3d0bed88)
- [コンテナ時代におけるオブザーバビリティの基礎 - エンジニアHub](https://eh-career.com/engineerhub/entry/2022/06/27/123000)
- [ログの適切な取得と保管｜総務省](https://www.soumu.go.jp/main_sosiki/joho_tsusin/security/business/admin/22.html)
- [予防に勝る防御なし - 堅牢なコードを導く様々な設計のヒント](https://speakerdeck.com/twada/growing-reliable-code-phperkaigi-2022)
- [初心者プログラマーに伝えたいデバッグの話 - Qiita](https://qiita.com/jyori112/items/2cd6e40b5570b90eda45)

---

### ログ

#### ログに残す項目

- タイムスタンプ
- 操作者
- ログ出力箇所
- メッセージ等
- ログ区分（エラー、警告、イベントなど）

#### ログの種類

| 種類 | 説明 |
|------|------|
| **アクセスログ** | リクエストログ |
| **検閲ログ** | 不正ログ、認証ログ |
| **操作ログ（監査ログ）** | マスターデータの操作など |
| **イベントログ** | 行動ログ（購入、ガチャなど） |
| **開発ログ** | エラー、デバッグ |

#### Node.jsのログライブラリ

**winston:**

```tsx
// src/context/logger.ts
import winston from 'winston';

const logger = winston.createLogger({
  level: 'info',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.json()
  ),
  transports: [
    new winston.transports.Console(),
    // new winston.transports.File({ filename: 'logfile.log' })
  ]
});

export default logger;
```

```tsx
import logger from './context/logger';

logger.debug('Debug Message');
logger.info('Info Message');
logger.warn('Warn Message');
logger.error('Error Message');
```

**morgan（Expressミドルウェア）:**

参考: [Express morgan middleware](https://expressjs.com/en/resources/middleware/morgan.html)

```tsx
import express from 'express';
import morgan from 'morgan';
import logger from './context/logger';

const app = express();
const port = 4000;

// morgan のログを winston を経由して出力する
app.use(morgan('combined', { stream: { write: message => logger.info(message.trim()) } }));

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.listen(port, () => {
  logger.info(`Server running on http://localhost:${port}`);
});
```

---

### デバッグ

コンピュータプログラムに潜む欠陥を探し出して取り除くこと。デバッグ作業を支援するソフトウェアを「デバッガ」（debugger）という。

#### デバッグの基本操作

- ブレークポイントを設置して処理を止める
- ステップ実行をして変数の値と処理の流れを把握する
- 条件付きのブレークポイントを設置する

#### コンテナ上のアプリケーションをデバッグするための設定

**package.json にデバッグ用スクリプトを追加:**

```json
"scripts": {
  "start": "node ./bin/www",
  "start:debug": "nodemon -L --inspect=0.0.0.0:9229 ./bin/www"
}
```

※nodemonが未インストールの場合は `npm install nodemon` を実施

**compose.yaml にデバッグポートを追加:**

```yaml
services:
  app:
    build: ./myapp
    tty: true
    ports:
      - 3000:3000
      - 9229:9229
```

**Dockerfile:**

```dockerfile
FROM node:lts
WORKDIR /usr/src/app
COPY . .
RUN npm install
EXPOSE 3000
EXPOSE 9229
CMD ["npm", "run", "start:debug"]
```

**launch.json（VSCode）:**

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "attach",
      "name": "Docker: Attach to Node",
      "port": 9229,
      "address": "localhost",
      "localRoot": "${workspaceFolder}/myapp",
      "remoteRoot": "/usr/src/app",
      "protocol": "inspector"
    }
  ]
}
```

---

### 例外処理

#### 例外とは

プログラムの実行中に起きる想定外の事態のこと。

#### throw

ユーザー定義の例外を発生させる。現在の関数の実行は停止し、コールスタック内の最初のcatchブロックに制御を移す。呼び出し元にcatchブロックが存在しない場合はプログラムが終了する。

#### try...catch

tryブロックの中で発生した例外をcatchブロックで捕捉する。

```jsx
function getRectArea(width, height) {
  if (isNaN(width) || isNaN(height)) {
    throw 'Parameter is not a number!';
  }
  return width * height;
}

try {
  getRectArea(3, 'A');
} catch (e) {
  console.error(e); // 'Parameter is not a number!'
}
```

---

### 課題（Must）

#### 1. Express.jsで作ったAPIサーバにログを仕込む

- ログをコンソールに出力する
- 少なくとも「エラーログ」「アクセスログ」「デバッグログ」を出す
- ログレベルを環境変数で定義して、出力するログを制御する

#### 2. コンテナ上のアプリをデバッグできるようにする

#### 3. バリデーションを実装する

- 各APIが想定していないリクエストが来たらエラーと分かるレスポンスを返す（型チェックなど）
- エラーの場合はクライアント側でユーザにエラーを表示する
- 意図的にエラーを発生させつつ、システムが落ちない例外処理を書く

---

### 課題提出

- `feature/express` ブランチにpush（pushしたらPRの内容が自動更新される）
- Section 4-5の課題提出タイミングまでに提出

---

## Section 4-3: ORM・Prisma

### レッスン内容

- ORMとは
- Prisma

### 課題

- ExpressサーバーでPrismaを使用してCRUD APIを作る

### 参考URL

- [Express & Prisma](https://www.prisma.io/express)
- [Prisma Reference](https://www.prisma.io/docs/reference)
- [Prisma Migrate](https://www.prisma.io/docs/concepts/components/prisma-migrate)

---

### ORM

ORMとは「Object-Relational Mapping」の略。データベースとオブジェクトのマッピングを行う。ソースコードに直接SQLを書くことなく、DBの操作が可能になる。

#### SQLとORMの比較

```sql
-- SQLの場合
SELECT * FROM users WHERE id = 1;
```

```tsx
// ORM（Prisma）の場合
prisma.user.findUnique({ where: { id } });
```

#### 主なORM

| 言語 | ORM |
|------|-----|
| Ruby (Ruby on Rails) | ActiveRecord |
| JavaScript, TypeScript (Node.js) | Prisma, TypeORM |
| PHP | Eloquent |
| Python | SQLAlchemy |

#### 用語

| 用語 | 説明 |
|------|------|
| **マイグレーション** | データベースのスキーマ（構造）をバージョン管理し、変更を適用する仕組み |
| **シーディング** | データベースに初期データを投入する仕組み |
| **トランザクション** | 複数のデータベース操作を一つのまとまりとして扱い、全て成功するか全て取り消すかを保証する仕組み |

---

### Prisma

TypeScriptで作られたORM。JavaScript、TypeScript両方で利用可能。

TypeScriptを利用している場合は、同じTypeScriptで開発されているライブラリを選定すると、エディタの型補完や言語特性を正しく使える場合が多い。

#### 主な構成要素

| 構成要素 | 説明 |
|---------|------|
| **Prisma Model** | モデル内でテーブルやカラムの定義を行う |
| **Prisma Schema** | Prismaの主要な設定ファイル。データソース、生成、データモデルの指定をする |
| **Prisma Client** | データベースクライアント |
| **Prisma Migrate** | Prisma Schemaの情報をもとにマイグレーション処理を可能にする |
| **Prisma Studio** | DB上のデータを閲覧編集するGUI |

#### 基本的なCRUD操作

**一覧取得:**

```tsx
const users = await prisma.user.findMany()
```

**登録:**

```tsx
const user = await prisma.user.create({
  data: {
    name: "msengineer",
    email: "msengineer@msengineer.com",
  },
})
```

**更新:**

```tsx
const user = await prisma.user.update({
  where: { id: 1 },
  data: {
    name: "ミズエンジニア",
  },
})
```

---

### 課題（Must）

家計簿アプリにデータベースを導入してデータを永続化する。

※CRUD = Create（生成）、Read（読み取り）、Update（更新）、Delete（削除）

- RDBをコンテナを使って起動する（MySQLかPostgreSQLを選択）
- Express.jsで作ったAPIサーバにPrismaを導入してCRUDできるようにする
- Prismaの設定ファイルとコマンドを使ってマイグレーションする
- Prismaを使って初期データが必要なテーブルにSeedingできるようにする
- Next.jsからAPIサーバを活用して家計簿アプリを完成させる

### 課題（Advanced）

- 家計簿アプリをAWSにデプロイする（EC2 or ECS）

---

### 課題提出

- `feature/express` ブランチにpush（pushしたらPRの内容が自動更新される）
- PRのURLをDiscordで共有してレビュー依頼
