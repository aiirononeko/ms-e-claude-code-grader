# Section 3: React + Next.js 教材リファレンス

## Section 3-1: React基礎

### レッスン内容

- Reactとは
- 仮想DOM
- JSXとは
- コンポーネント
- React Router

### 課題

- Reactで家計簿アプリの画面側を作成する

### 参考URL

- [React公式HP](https://ja.react.dev/)

---

### Reactとは

Webアプリケーションの UI を構築するための JavaScript ライブラリ。UIを「コンポーネント」という小さく独立した部品を組み合わせて構築することができる。

#### UI（ユーザインタフェース）とは

ユーザと製品やサービスとの接点のこと。ブラウザで表示される画面もシステムとのインタフェースと捉えることができる。

#### コンポーネントとは

UIを構成する要素を再利用可能な部品として定義するための仕組み。

#### アトミックデザイン

UIを構成する要素を5つのコンポーネントレイヤーに分解し、順番に設計していく手法。

| レイヤー | 説明 | 例 |
|---------|------|-----|
| **原子 (Atoms)** | UIを構成する最小単位のパーツ | ボタン、フォント、アイコン |
| **分子 (Molecules)** | 原子を組み合わせてできるパーツ。一定の意味を持つが固定された役割はない | 入力フォーム、検索バー |
| **生体 (Organisms)** | 原子や分子を組み合わせた、特定の機能を持つパーツ | ヘッダー、フッター |
| **テンプレート (Templates)** | ページ全体の骨組み。原子・分子・生体を組み合わせて作成 | ページレイアウト |
| **ページ (Pages)** | ユーザーが閲覧するUIの最終形態。テンプレートに実際のコンテンツを追加 | 完成画面 |

※近年はこの過剰なコンポーネント分割が生産性を低下させるとして、アトミックデザイン的なアプローチを取りつつ厳密にはやり過ぎない設計が多く試されている。

参考:
- [Atomic Design](https://bradfrost.com/blog/post/atomic-web-design/)
- [Atomic Design を分かったつもりになる - DeNA Design](https://design.dena.com/design/atomic-design-を分かったつもりになる)
- [Atomic Designをやめてディレクトリ構造を見直した話｜食べログ](https://note.com/tabelog_frontend/n/n07b4077f5cf3)
- [フロントエンドのコンポーネント設計で気をつけているn個のこと - Uzabase](https://tech.uzabase.com/entry/2020/03/31/081351)

#### ライブラリとは

よく使うプログラムを取り出してまとめたもの。何度も利用する機能をゼロから作る必要がなくなるため、効率的に開発を行うことができる。

#### Reactの特徴

- **コンポーネントベース**
- **宣言的UI**
- **Webアプリ以外にも、ネイティブアプリのView部分として利用できる**

---

### 仮想DOM

Reactでは、実際にブラウザに表示されているDOMとは切り離されたメモリ上にDOM構造を保持しており、任意の処理を仮想DOMに対して適用した後、実際のDOMに部分的に反映させるアプローチをとっている。

#### 仮想DOMのメリット

- 必要な部分だけレンダリングすることによる処理コストの軽量化 → 高速化
- 仮想DOM（実体はJavaScriptのオブジェクト）に対する操作なので、柔軟性がある

---

### JSX（TSX）

JavaScriptの拡張構文。JavaScript内でHTMLのような表現をすることができる。Reactの要素を生成する。

```tsx
const element = <h1>Hello, World</h1>
```

#### JSXに式を埋め込む

```tsx
const name = 'Ms Engineer';
const element = <h1>Hello, {name}</h1>;
```

```tsx
interface Address {
  prefecture: string;
  city: string;
}

function formatAddress(address: Address): string {
  return address.prefecture + ' ' + address.city;
}

const address: Address = {
  prefecture: 'Tokyo',
  city: 'Shibuya'
};

const element = (
  <h1>
    I live in, {formatAddress(address)}!
  </h1>
);
```

参考: [ドキュメントオブジェクトモデルの使用 - MDN](https://developer.mozilla.org/ja/docs/Web/API/Document_object_model/Using_the_Document_Object_Model)

---

### コンポーネント

画面にReact要素を表示するための部品。React要素を返す。コンポーネントはクラスや関数で表現されるが、現在は関数コンポーネントが主流。

#### クラスコンポーネント

`React.Component` クラスを継承したJavaScriptのクラスとしてコンポーネントを定義する。

- `constructor`: コンポーネントの初期化処理などを記述
- `render`: コンポーネントが描画される際に呼び出され、JSX要素を返す

```jsx
class Welcome extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      class: "Ms.Engineer"
    }
  }
  render() {
    return <h2>Welcome to {this.props.class}</h2>
  }
}
```

#### 関数コンポーネント

関数の形式でReactのコンポーネントを定義する。

- 関数名: コンポーネントの名前として定義
- return: JSX要素を返すことを期待される

```jsx
function Welcome(props) {
  return <h2>Welcome to {props.class}</h2>;
}
```

※props: 親コンポーネントから子コンポーネントへデータを渡す仕組み

---

### React Router

Reactでルーティング（ページ遷移）を可能にするライブラリ。

#### インストール

```bash
npm install react-router-dom
```

#### インポート

```tsx
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
```

#### 主要コンポーネント

| コンポーネント | 説明 |
|-------------|------|
| **BrowserRouter** (Router) | ルーティングコンテナ。ブラウザのURLとコンポーネントをマッピングする |
| **Routes** | `Route` コンポーネントを子要素として保持し、マッチした `Route` に対応するコンポーネントを表示 |
| **Route** | 特定のURLパスに対応するコンポーネントを表示。`path` と `element` プロパティを指定 |
| **Link** | クリックすると特定のURLに遷移するナビゲーションリンクを作成。`to` プロパティでリンク先を指定 |

#### サンプルコード

```tsx
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import React from 'react';

const Home: React.FC = () => <h1>Home</h1>;
const About: React.FC = () => <h1>About</h1>;
const Contact: React.FC = () => <h1>Contact</h1>;

const App: React.FC = () => {
  return (
    <>
      <Router>
        <nav>
          <ul>
            <li><Link to="/">Home</Link></li>
            <li><Link to="/about">About</Link></li>
            <li><Link to="/contact">Contact</Link></li>
          </ul>
        </nav>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/about" element={<About />} />
          <Route path="/contact" element={<Contact />} />
        </Routes>
      </Router>
    </>
  );
}

export default App;
```

---

### 課題（Must）

Reactで家計簿アプリの画面を作成する。※データはアプリ内にべた書き（データモック）でよい。

要件:
- TypeScriptを使用すること
- 入出金の履歴を一覧で閲覧できること
- 入出金履歴の一覧ページから詳細情報を確認するページに遷移できること
- 月ごとの入出金履歴と入金・出金の差額を算出して確認できること
- データの表示だけでOK（登録・更新・削除は後で実装）
- コンポーネントを適切な要素に分けて再利用可能にする（propsを使用）
- Reactの起動コマンドを修正してホットリロードできるようにする
- Docker, docker composeを使ってアプリケーションを起動できるようにする

### 課題（Advanced）

- Reactをビルドして、Docker上のNginxで表示する
- マウスが乗ったら影が出るなどのマイクロインタラクションを実装する
- ページ遷移時にアニメーションを実装する

---

### 補足: 環境構築手順

#### アプリケーション作成

```bash
npm create vite@latest client
```

※viteを使ってReactプロジェクトのテンプレートを生成

#### 起動確認

```bash
cd client
npm install
npm run dev
```

#### コンテナ環境サンプル

**Dockerfile（package.jsonと同じ階層に作成）:**

```dockerfile
FROM node:lts
WORKDIR /usr/src/app
COPY . .
RUN npm install
EXPOSE 3000
CMD ["npm", "run", "dev"]
```

**compose.yaml（clientディレクトリと同じ階層に作成）:**

```yaml
services:
  react:
    build:
      context: ./client
      dockerfile: Dockerfile
    ports:
      - "3000:3000"
    environment:
      - PORT=3000
    volumes:
      - ./client:/usr/src/app
      - /app/node_modules
    command: npm run dev
```

```bash
# 起動
docker compose up -d --build

# 停止
docker compose down
```

---

### 課題提出

- PRを作成して提出（mainブランチから `feature/react` ブランチを作成、マージはしない）
- Section 3-3の課題提出タイミングまでに提出

---

## Section 3-2: React Hooks・状態管理・データ取得

### レッスン内容

- Hooks
- 状態管理
- ライフサイクル
- データ取得処理（Promise）
- コンポーネント間のリソース共有

### 課題

- React part1で作った家計簿アプリをバージョンアップさせる

### 参考URL

- [組み込みの React フック](https://ja.react.dev/reference/react/hooks)
- [state の管理](https://ja.react.dev/learn/managing-state)
- [useEffect](https://ja.react.dev/reference/react/useEffect#fetching-data-with-effects)
- [エフェクトは必要ないかもしれない](https://ja.react.dev/learn/you-might-not-need-an-effect)

---

### Hooks

React 16.8 で追加された機能。関数コンポーネントに state やライフサイクルといったReactの機能を"接続する（hook into）"ための関数。クラスなしにReactを使うための機能。

参考: [Rules of Hooks](https://ja.react.dev/reference/rules/rules-of-hooks)

#### 主要なHooks

| Hook | 用途 |
|------|------|
| `useState` | コンポーネントに状態を保持させる |
| `useEffect` | 副作用（API呼び出しなど）を実行する |
| `useContext` | コンテキストの値を参照する |
| `useReducer` | 複雑な状態ロジックを管理する |
| `useCallback` | 関数をメモ化する |
| `useMemo` | 計算結果をメモ化する |

---

### 状態管理（useState）

React Hooksの一つであるuseStateによってコンポーネントに状態を保持させることが可能。

```tsx
import React, { useState } from 'react';

const Example: React.FC = () => {
  const [count, setCount] = useState<number>(0);

  return (
    <div>
      <p>あなたは {count} 回クリックしました。</p>
      <button onClick={() => setCount(count + 1)}>
        Click me
      </button>
    </div>
  );
}

export default Example;
```

`useState` 関数は初期値を引数に取り、状態変数 `count` と状態を変更するための関数 `setCount` を返す。

---

### ライフサイクル

コンポーネントには画面に表示されてから消去されるまでの一連の流れ（ライフサイクル）が存在する。

| フェーズ | 説明 |
|---------|------|
| **Mounting（マウント時）** | コンポーネントが生成されて表示されるまでの期間 |
| **Updating（更新時）** | コンポーネント内のデータが更新される期間 |
| **Unmounting（マウント解除時）** | コンポーネントが生成したDOMが削除される期間 |

参考: https://projects.wojtekmaj.pl/react-lifecycle-methods-diagram/

#### useEffect

React Hooksの一つであるuseEffectによって関数コンポーネントに任意の副作用（API呼び出しなど）を持たせることができる。

```tsx
import React, { useState, useEffect } from 'react';

const Example: React.FC = () => {
  const [count, setCount] = useState<number>(0);

  useEffect(() => {
    document.title = `${count} 回クリックしました`;
  });

  return (
    <div>
      <p>あなたは {count} 回クリックしました。</p>
      <button onClick={() => setCount(count + 1)}>
        Click me
      </button>
    </div>
  );
}

export default Example;
```

#### useEffectの第2引数による実行タイミング制御

| 第2引数 | 実行タイミング |
|---------|-------------|
| なし | レンダリング後に毎回実行 |
| `[]`（空の配列） | マウント・アンマウント時のみ実行 |
| `[count]`（値の入った配列） | 最初のマウント時と、与えられた値に変化があった場合のみ実行 |

```tsx
// 第2引数なし: 毎回実行
useEffect(() => {
  document.title = `${count} 回クリックしました`;
});

// 空の配列: マウント・アンマウント時のみ
useEffect(() => {
  document.title = `${count} 回クリックしました`;
}, []);

// 値の入った配列: countが変化した時のみ
useEffect(() => {
  document.title = `${count} 回クリックしました`;
}, [count]);
```

---

### データ取得処理

Reactでは fetch API などを使って、ネットワーク越しのリソースを利用することが可能。

参考: [fetch() - MDN](https://developer.mozilla.org/ja/docs/Web/API/fetch)

#### fetchメソッドの構文

```jsx
fetch(resource)
fetch(resource, options) // optionsは任意
```

fetch() はネットワークからリソースを取得するプロセスを開始し、レスポンスが利用できるようになったら履行されるプロミスを返す。

#### Promise（プロミス）

非同期処理を扱うためのオブジェクト。非同期処理が完了した際に値を返す。

| 状態 | 説明 |
|------|------|
| **Pending** | 初期状態。処理完了まで待機 |
| **Fulfilled** | 処理成功。処理の結果を利用できる |
| **Rejected** | 処理失敗。エラーが発生 |

```jsx
new Promise(function(resolve, reject) {
  if (/* 処理が成功した場合 */) {
    resolve(value);  // 成功した状態
  } else {
    reject(error);   // 失敗した状態
  }
})
.then(function(result) {
  // resolve時に実行
})
.catch(function(error) {
  // reject時に実行
});
```

#### fetchメソッドの使い方

fetchはHTTPステータスを見てrejectしない。通信が成功した場合でもResponseのプロパティを見て処理を分岐させる必要がある。

```tsx
useEffect(() => {
  const reqHeaders = new Headers();
  reqHeaders.append('xxxxxxxxxxxxx', 'xxxxxxxxxxxxx');

  const requestOptions: RequestInit = {
    method: 'GET',
    headers: reqHeaders,
  };

  const api_endpoint = 'https://xxxxxxx.com/api/xxxx/xxxxx';

  fetch(api_endpoint, requestOptions)
    .then(response => {
      if (!response.ok) {
        if (response.status === 404) {
          throw new Error('Not Found');
        } else if (response.status === 500) {
          throw new Error('Internal Server Error');
        } else {
          throw new Error('Network response was not ok');
        }
      }
      return response.json();
    })
    .then(result => {
      // 成功した場合の処理
    })
    .catch(error => {
      console.error('Error:', error);
    });
}, []);
```

---

### 関数やHooksの共有

Reactではコンポーネントが階層構造を持ってViewを構築するため、あるコンポーネントに定義された関数やHooksをpropsなどを通して別のコンポーネントに渡し、渡した先で実行することがある。

参考: [コンポーネントにpropsを渡す](https://ja.react.dev/learn/passing-props-to-a-component)

#### 例: 親コンポーネントから子コンポーネントへの関数の受け渡し

**App.tsx（親コンポーネント）:**

```tsx
import React, { useState } from 'react'
import Button from './Button';

const App: React.FC = () => {
  const [count, setCount] = useState<number>(0);

  function countUp(): void {
    setCount(count + 1);
  }

  function countDown(): void {
    setCount(count - 1);
  }

  return (
    <div className="App">
      <p>Count: {count}</p>
      <Button clickFunc={countUp} inner={'count up!'} />
      <Button clickFunc={countDown} inner={'count down!'} />
    </div>
  );
}

export default App
```

**Button.tsx（子コンポーネント）:**

```tsx
import React from 'react';

interface ButtonProps {
  inner: string;
  clickFunc: () => void;
}

const Button: React.FC<ButtonProps> = ({ inner, clickFunc }: ButtonProps) => {
  return (
    <>
      <button type="button" onClick={() => clickFunc()}>
        {inner}
      </button>
    </>
  );
}

export default Button;
```

---

### 課題（Must）

家計簿アプリのバージョンアップ:

- ツールやサービスを使ってAPIのモックを作成する
  - 開発中のReactからfetchでリクエストできるようにする
  - 例: SSSAPI, json-server など
- 作成したAPIモックから `fetch` などでデータを取得してコンポーネントを表示する
- `ChakraUI` `Tailwind CSS` などのCSSフレームワークを使って画面を装飾する
- 家計の登録フォームを作成する
  - useStateを利用してフォームの状態を管理する
  - useEffectを利用してフォームの入力値を登録する
- 家計の詳細画面で「更新」ボタンを押したら入力フォームに切り替わるようにする
  - 入力フォームには変更前の値を初期値として表示する
  - 登録フォーム同様にuseEffectなどで入力値を更新する

### 課題（Advanced）

1. `build` したアプリケーションをAWS S3で表示できるようにする（Section 2-1で作ったバケットを使用）
2. データ取得処理に `SWR` を導入する

---

### 課題提出

- `feature/react` ブランチにpush（pushしたらPRの内容が自動更新される）
- Section 3-3の課題提出タイミングまでに提出

---

## Section 3-3: アクセシビリティ・ディレクトリ構成・高階関数

### レッスン内容

- アクセシビリティ
- ディレクトリ構成
- 関数式・アロー関数
- ループ処理
- 組み込み高階関数

### 課題

- React part2で作った家計簿アプリをバージョンアップさせる

### 参考URL

- [マイクロインタラクション入門｜Goodpatch Blog](https://goodpatch.com/blog/ui-micro-interaction)
- [WCAG 2.1](https://www.w3.org/TR/WCAG21/)
- [ウェブアクセシビリティ導入ガイドブック｜デジタル庁](https://www.digital.go.jp/resources/introduction-to-web-accessibility-guidebook)
- [Ameba Accessibility Guidelines](https://a11y-guidelines.ameba.design/)
- [Atomic Design を分かったつもりになる - DeNA Design](https://design.dena.com/design/atomic-design-を分かったつもりになる)
- [食べログでのAtomic Design](https://note.com/tabelog_frontend/n/n4b8bcb44294c)
- [Atomic Designをやめてディレクトリ構造を見直した話｜食べログ](https://note.com/tabelog_frontend/n/n07b4077f5cf3)

---

### アクセシビリティ（A11Y）

障がいを持つ人々を含むすべての人が、製品やサービスを利用できるようにするための設計。ウェブアクセシビリティは、特にウェブサイトやアプリケーションがすべての人にとって使いやすいようにすることを指す。

#### 4つの原則

| 原則 | 説明 |
|------|------|
| **Perceivable（知覚可能）** | 情報やUIコンポーネントがユーザーに知覚可能な方法で提示されること |
| **Operable（操作性）** | UIコンポーネントやナビゲーションが操作可能であること |
| **Understandable（理解可能）** | 情報やUIの操作が理解可能であること |
| **Robust（堅牢性）** | さまざまなユーザーエージェントで正しく解釈されること |

---

### ディレクトリ構成

ソフトウェアは一般的にチームで開発して中長期にわたって保守・拡張していく。人間が理解しやすいディレクトリ構造・ソースコードにして保守性・拡張性を保つ必要がある。

#### アトミックデザインベース

```
my-app/
├─ src/
│  ├─ components/
│  │  ├─ atoms/          # 最も基本的なUI要素（ボタン、インプット等）
│  │  ├─ molecules/      # アトムを組み合わせたUIコンポーネント（検索フォーム等）
│  │  ├─ organisms/      # モレキュールを組み合わせた複雑なUIセクション（ヘッダー等）
│  │  ├─ templates/      # ページのレイアウトを定義するフレームワーク
│  │  ├─ pages/          # テンプレートにデータを注入した実際のページ
│  ├─ App.jsx
│  ├─ index.jsx
```

#### 機能ベース（features directory）

再利用可能なUIコンポーネントは `components` に格納し、機能に特有のコンポーネントやスタイリングを `features/機能名` というディレクトリで管理する方法。

```
my-app/
├─ src/
│  ├─ components/        # 再利用可能なUIコンポーネント
│  │  ├─ Button/
│  │  ├─ Modal/
│  ├─ features/          # アプリケーションの各機能
│  │  ├─ Dashboard/
│  │  │  ├─ components/  # ダッシュボード固有のコンポーネント
│  │  │  ├─ Dashboard.jsx
│  │  ├─ Profile/
│  │  │  ├─ components/  # プロファイル固有のコンポーネント
│  │  │  ├─ Profile.jsx
│  ├─ App.jsx
│  ├─ index.jsx
```

※ディレクトリ構成に絶対的な正解はない。保守性や拡張性を落とさないようにシステムの肥大化に伴ってディレクトリ構成を改善していくアプローチが重要。

---

### 関数式・アロー関数

JavaScriptでは関数は第一級オブジェクトであり、変数に代入したり関数の引数に指定することができる。

#### 関数式

```jsx
const myFunction = function() {
  console.log("Hello, World!");
};
myFunction(); // "Hello, World!"
```

#### アロー関数

関数を省略して簡潔に記述できる。

```jsx
const myFunction = (msg) => {
  console.log(msg);
};
myFunction("Hello, World"); // "Hello, World!"
```

---

### ループ処理

#### `for...in` ループ

オブジェクトのすべての列挙可能なプロパティを通じて反復処理を行う。

```jsx
const obj = { a: 1, b: 2, c: 3 };

for (const key in obj) {
  console.log(key, obj[key]);
}
// a 1, b 2, c 3
```

#### `for...of` ループ

配列などの各要素に対して反復処理が行われる。

```jsx
const array = [10, 20, 30];

for (const value of array) {
  console.log(value);
}
// 10, 20, 30
```

---

### 高階関数

他の関数を引数として受け取るか、関数を結果として返す関数のこと。コードの可読性や再利用性、抽象度を高めることができる。

```jsx
function repeat(n, action) {
  for (let i = 0; i < n; i++) {
    action(i);
  }
}
repeat(3, console.log); // 0, 1, 2
```

#### JavaScriptの組み込み高階関数

**Array.prototype.map** — 配列の各要素に関数を適用し、新しい配列を作成:

```jsx
const numbers = [1, 2, 3, 4];
const doubled = numbers.map(x => x * 2);
console.log(doubled); // [2, 4, 6, 8]
```

**Array.prototype.filter** — 条件に一致する要素だけを含む新しい配列を作成:

```jsx
const numbers = [1, 2, 3, 4];
const evens = numbers.filter(x => x % 2 === 0);
console.log(evens); // [2, 4]
```

**Array.prototype.reduce** — 配列の各要素を順に処理し、単一の結果値に統合:

```jsx
const numbers = [1, 2, 3, 4];
const sum = numbers.reduce((acc, x) => acc + x, 0);
console.log(sum); // 10
```

---

### 課題（Must）

- Reactのディレクトリ構成を考えて、必要ならリファクタリングする
- Reactのコンポーネントを関数式 + アロー関数で記述する
- 繰り返し表示する要素は組み込み高階関数を使って表示する

### 課題（Advanced）

- アクセシビリティに配慮した実装をする（マイクロインタラクションなど）

---

### 課題提出

- `feature/react` ブランチにpush（pushしたらPRの内容が自動更新される）
- PRのURLをDiscordで共有してレビュー依頼

---

## Section 3-4: Next.js基礎

### レッスン内容

- Next.jsとは
- フレームワークとは
- ルーティング
- CSR, SSR, ISR, SSG

### 課題

- Reactで作った家計簿アプリをNext.jsで書き直す

### 参考URL

- [Next.js公式ドキュメント](https://nextjs.org/docs)
- [ルーティング実装はnext/routerとnext/linkどちらが最適解なのか](https://zenn.dev/taizo_pro/articles/8e9c47f2dbe44e)

---

### Next.jsとは

オープンソースのReactベースのフロントエンドフレームワーク。Vercelという企業がメインで作成している。

#### 特徴

- **サーバー機能がある**: SSGとSSRの両方のpre-rendering方式をページごとにサポート。APIを作成することもできる
- **ルーティング**: react-routerなどのライブラリを使用しなくても、特定の場所にファイルを配置すればルーティングできる。`pages router` と Next 13以降の `app router` で仕様が異なる
- **リソース最適化**: 画像などの遅延ローディングや各リソースの最適化（圧縮）など、パフォーマンスに重要な機能が組み込まれている

---

### フレームワークとは

開発に必要な機能をまとめた「枠組み」「道具箱」のようなもの。フレームワークを使用すると1から全てを作る必要がなくなり、開発効率を上げることが可能。

#### 主なフレームワーク

| 言語 | フレームワーク |
|------|-------------|
| Ruby | Ruby on Rails |
| JavaScript (Node.js) | Express, Nest.js |
| PHP | Laravel |
| Python | Django, FastAPI, Flask |
| Java | Spring, Play |

#### フレームワークの設計思想

各フレームワークには設計思想があり、フレームワークの用意した設計思想を考慮して開発することでメリットを最大限享受できる。

**Next.jsの設計思想の遷移:**

- **pages router時代**: デフォルトがクライアントサイドで動作するコンポーネント。React同様にクライアントサイドに重きを置き、サーバーサイドの機能は補助的な役割
- **app router時代**: デフォルトがサーバーコンポーネント。サーバー機能を有効活用したアプリケーション作成に加えて、クライアントサイドでも柔軟性を維持した設計

---

### CSR, SSR, ISR, SSG

| 方式 | 正式名称 | 説明 |
|------|---------|------|
| **CSR** | Client Side Rendering | JavaScriptを利用してブラウザ上でコンテンツをレンダリングする方式 |
| **SSR** | Server Side Rendering | サーバー側でレンダリングしたコンテンツをクライアント側に返却する方式 |
| **SSG** | Static Site Generator | あらかじめ静的ファイルを生成しておく方式 |
| **ISR** | Incremental Static Regeneration | SSGベースでコンテンツを提供しつつ、定期的にサーバーサイドでレンダリングしてコンテンツを更新する方式 |

---

### 課題（Must）

Reactで作った家計簿アプリをNext.jsで再構築する:

- Reactのコンポーネントを再利用しても問題ない
- `Chakra UI` `Tailwind CSS` などを使って画面を装飾する
- クライアント側からのデータ取得処理は `SWR` を利用する
- アプリケーションは `app router` で作成する

### 課題（Advanced）

- 個人でVercelのアカウントを作成しデプロイする
- アプリケーションはコンテナ環境で動作させる

### 課題（Challenge）

- Remixでアプリケーションをリプレイスする

---

### 補足: 環境構築手順

#### アプリケーション作成

```bash
npx create-next-app@latest
```

対話型インターフェースの回答例:

```
What is your project named? client
Would you like to use TypeScript? Yes
Would you like to use ESLint? Yes
Would you like to use Tailwind CSS? Yes
Would you like to use `src/` directory? Yes
Would you like to use App Router? (recommended) Yes
Would you like to customize the default import alias? No
```

#### 起動確認

```bash
cd client
npm run dev
```

#### コンテナ環境サンプル

**Dockerfile（package.jsonと同じ階層に作成）:**

```dockerfile
FROM node:lts
WORKDIR /usr/src/app
COPY . .
RUN npm install
EXPOSE 3000
CMD ["npm", "run", "dev"]
```

**compose.yaml（clientディレクトリと同じ階層に作成）:**

```yaml
services:
  next:
    build:
      context: ./client
      dockerfile: Dockerfile
    ports:
      - "3000:3000"
    environment:
      - PORT=3000
    volumes:
      - ./client:/usr/src/app
      - /app/node_modules
    command: npm run dev
```

```bash
# 起動
docker compose up -d --build

# 停止
docker compose down
```

---

### 課題提出

- PRを作成して提出（mainブランチから `feature/next` ブランチを作成、マージはしない）
- Section 3-5の課題提出タイミングまでに提出
