# 既存手法 {#conventional_method}
本章では既存のゲームレベル生成環境について述べる.
[@sec:gvgai]では,
エージェント,ゲーム,レベル生成アルゴリズムを評価するため
フレームワークであるGeneral Video Game AI[@gvgai]について.
[@sec:vgdl]では,ゲームの記述表現であるVideo Game Description Language[@vgdl]
について述べる.


## General Video Game AI {#sec:gvgai}
General Video Game AI(以下GVGAI)[@gvgai;@gvgaibook2019]は既存のゲームよるAIのテスト環境
が単一のゲームに対する学習の過剰適合や局所性の高い環境となっているのに
対してよりAIが一般的な能力が評価できる環境として当初開発された.
既存環境としてよく知られているMs Pac-Man[@bellemare13arcade],StarCraft[@starcraft]では
よりプレイ能力の高いAIを開発するためにゲーム特有の攻略法が思考に組み込まれた.
このため,AIが他のゲームをプレイするための一般的な能力の向上に繋がらないとした.

GVGAIではゲームプレイするAIは固有知識によるプレイの局所化を防止するため
AIが実際のプレイするゲームについて学習時にはプレイできないようにした.

またGVGAIは定期的にコンペディションを行いAIの評価を行った.その際に使用されるゲームは
学習時の環境には存在しない新たなゲームを作成した.

GVGAIで実装されているゲームについて数例示す.

\newpage

* aliens

![aliensのプレイ画面](img/alien.png){#fig:aliens}

\
aliensはスペースインベンダー[@spaceinvader]に似たゲーム.
プレイヤはスクリーンの下で横移動のみ可能.
プレイヤは上方向に球を発射することができる.
敵にプレイヤが接触するか全ての敵を倒すと終了する.
[@fig:aliens]にaliensのプレイ画面を示す.


* frog

![frogのプレイ画面](img/frog.png){#fig:frog}

\
frogはフロッガー[@frogger]に似たゲーム.トラックが通る道路と橋が流れる川をプレイヤである
カエルがトラックにぶつからず,川に落ちずに渡りきることが目標である.
[@fig:frog]にfrogのプレイ画面を示す.

* zelda

![zeldaのプレイ画面](img/zelda.png){#fig:zelda}

\
zeldaはゼルダの伝説[@zelda]に似たゲーム.
プレイヤは迷路の中で鍵を見つけてドアを開いて出る必要がある.
プレイヤは剣を装備しており敵を倒すことができる,敵に接触した場合
失敗,脱出できれば成功.
[@fig:zelda]にzeldaのプレイ画面を示す.



GVGAIは開発の当初においてレベル生成に関わるフレームワークを搭載されていなかったが,
後にGeneral Video Game Level Generation (GVG-LG)[@gvgai-level]としてGVGAIの上に搭載された

GCGAIにおけるレベル評価の方法としてコンペディションでレベル生成アルゴリズムを用いてレベルを生成し,
コンペディションに来場した人にレベルの中のを２つプレイしてもらい,好きなレベルを片方,両方,どちらでもない
で評価し,結果を集計した.


GVG-LGではGVGAIで実装されているゲーム全てがレベル生成可能である.

## Video Game Description Language {#sec:vgdl}
GVGAI内の全てのゲームはVideo Game Description Language(以下VGDL)で表現されている.
VGDLはテキストベースの記述言語である.Tom Schaul[@vgdl]によって開発された.
VGDLは2次元アーケードゲームを対象として設計されている.
ゲーム上のオブジェクトは敵とプレイヤがあり,オブジェクトにはスプライトと
矩形の物理判定がある.
VGDLはロジックの記述ををゲームとレベルの2つの要素に分離している.

ゲームロジックは4つのブロックで構成されている.
ゲームロジックはゲームがどのように動作するかについて宣言する.


* Sprite Set : ゲーム内で使用できるスプライトとそのプロパティを宣言する.
* Interaction Set : オブジェクト同士が衝突したときにそのイベントを宣言する.
* Termination Set : ゲームの終了条件を宣言する.
* Level Mapping : レベルでの文字とSprite Setで設定された関係性を宣言する.

[@fig:vgdlgame]はゲームAliensの定義ファイルである.

![Aliensのゲーム定義ファイル](img/code.png){#fig:vgdlgame}

\


レベルはLevelMappingで定義されたオブジェクトの配置について記述する.
[@fig:vgdl-level]にゲームAliensのレベルの例を示す.

![VGDLのレベル表現](img/vdgl-level.png){#fig:vgdl-level}

\

GVGAIでは200のゲームが現在実装されている[@gvgaibook2019].
一方で各ゲームでは5レベルのみしか与えられないため,
機械学習によって生成することは難しい.

Summerville[@vglc]はレベル拡張として12のゲームから428レベル
を構築した.このデータセットをVideo Game Level Corpus(以下VGLC)とした.

[@tbl:vglc]にVGLCで構築されたデータセットを示す.


\newpage

| ゲーム| レベル数|
|--- | --- |
|Super Mario Bros. | 20|
|Super Mario Bros. 2 | 25 |
|Super Mairo Land | 9 |
|Super Mario Kart | 7|
|Kid Icarus | 6 | 
|Lode Runner | 150|
|Rainbow Islands | 28 | 
| Doom | 36 |
|Doom 2 | 32 |
|The Legend of Zelda | 9 |
:VGLCに含まれるコーパス {#tbl:vglc}




VGLCによる拡張によってレベル数は増加したが,
依然として学習への使用は難しい.