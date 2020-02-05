# 提案手法 {#proposed_method}

第3章より既存の環境では学習に使える環境として不足している.このため
新しい環境が必要となる.

本章では,スーパーマリオメーカー２にコンソール外部からレベルを
操作可能にする環境であるsmm2Builderについて述べる.
[@sec:task]ではsmm2Builderが実装する必要がある機能について
[@sec:impl]では実装について述べる.

## 要求定義 {#sec:task}
本節では,生成ための学習に使用する環境として,達成すべき機能について述べる.

スーパーマリオメーカー2ではレベルデータをコンソールから抽出することができる.
抽出したデータはBCDファイルと呼ばれる.
BCDファイルはバイナリで暗号化されているため復号化する必要がある.

復号後のBCDファイルは扱いやすい形式に変換,また視覚的にレベルの表現が分かりやすい様にする必要がある.
さらに,学習に使える方に変換する必要がある.

以上よりsmm2Builderに必要な機能を列挙する.

* コンソールからのレベルデータの抽出,挿入
* レベルデータをjsonに変換
* レベルデータを画像に変換
* レベルデータを機械学習用表現に変換.
* 生成モデルからの出力をコンソールが読み込めるフォーマット(BCD)に変換.


## 実装 {#sec:impl}

本実装ではコンソールからのレベルデータの取得,レベルデータの
json化,画像化,レベルデータの機械学習のための変換処理,生成したレベルの
コンソールへの読み込みが可能にする環境を実装する.

### 処理の流れ
本節では,本実装の全体の流れを説明する.

1. コンソールからBCDを抽出
2. BCDを復号化Jsonに変換
3. Jsonを画像とObjectMapに変換
4. ObjectMapを用いて生成モデルで学習
5. 生成モデルからの出力をBCDに変換
6. コンソールで読み込み

以上の流れによる変換を可能にする環境を実装する.
[@fig:smm2flow]に変換の流れを示す.

![変換の流れ](img/flow.png){#fig:smm2flow}

\

### レベルの抽出,挿入

コンソールからのレベルデータの抽出,挿入にはセーブデータ管理ツールである
[Edizon](https://github.com/WerWolv/EdiZon)を使用した.

Edizonはゲームのセーブファイルのダンプ,インジェクションを可能にするツールである.

[@fig:edizon]に動作画面を示す.

![Edizon動作画面](img/edizon.jpg){#fig:edizon}

\

Edizonを使用することでBCDファイルの抽出,挿入が可能となる.

### レベルの変換
  
 まず,BCDをjsonに変換する.次に,jsonを次節で説明するObjectMapフォーマットと
 オブジェクトを配置した画像に変換する.
 
#### BCD to Json
  Edizonを用いて抽出したsmm2のレベルファイルの形式であるBCDファイルは
  バイナリファイルであるため,編集,確認がしやすいフォーマットであるJsonに変換する.
  現在,BCDからJsonへのマッピングの際に学習の表現のために一部のオブジェクト,プロパティを
  省略するようにした.
  ObjectMapフォーマットではオブジェクトの幅,高さ共に1に制限されるため,
  高さが1を超えるオブジェクトは変換されない.
  [@tbl:objectTable]に変換可能なオブジェクトを示す.
  本論文では39種類のオブジェクトを変換可能にした.
    
  | id | name | sprite| 
  | --- | --- | --- | 
  | 0 |goomba | ![goomba](img/script/tile/goomba.png) | 
  | 1 |troopa | ![troopa](img/script/tile/troopa.png) | 
  | 3 |hammerbros | ![hammerbros](img/script/tile/hammerbros.png) | 
  | 4 |block | ![block](img/script/tile/block.png) | 
  | 5 |question_block | ![question_block](img/script/tile/question_block.png) | 
  | 6 |hard_block | ![hard_block](img/script/tile/hard_block.png) | 
  | 7 |ground | ![ground](img/script/tile/ground.png) | 
  | 8 |coin | ![coin](img/script/tile/coin.png) | 
  | 10 |trampoline | ![trampoline](img/script/tile/trampoline.png) | 
  | 15 |bob_omb | ![bob_omb](img/script/tile/bob_omb.png) | 
  | 18 |p_switch | ![p_switch](img/script/tile/p_switch.png) | 
  | 19 |pow_block | ![pow_block](img/script/tile/pow_block.png) | 
  | 20 |super_mushroom | ![super_mushroom](img/script/tile/super_mushroom.png) | 
  | 21 |donut_block | ![donut_block](img/script/tile/donut_block.png) | 
  | 22 |cloud_block | ![cloud_block](img/script/tile/cloud_block.png) | 
  | 23 |note_block | ![note_block](img/script/tile/note_block.png) | 
  | 25 |spiny | ![spiny](img/script/tile/spiny.png) | 
  | 28 |buzzy_beetle | ![buzzy_beetle](img/script/tile/buzzy_beetle.png) | 
  | 29 |hidden_block | ![hidden_block](img/script/tile/hidden_block.png) | 
  | 33 |one_up_mushroom | ![one_up_mushroom](img/script/tile/one_up_mushroom.png) | 
  | 34 |fire_flower | ![fire_flower](img/script/tile/fire_flower.png) | 
  | 35 |super_star | ![super_star](img/script/tile/super_star.png) | 
  | 39 |kamek | ![kamek](img/script/tile/kamek.png) | 
  | 40 |spike_top | ![spike_top](img/script/tile/spike_top.png) | 
  | 41 |boo | ![boo](img/script/tile/boo.png) | 
  | 43 |spike_trap | ![spike_trap](img/script/tile/spike_trap.png) | 
  | 46 |dry_bones | ![dry_bones](img/script/tile/dry_bones.png) | 
  | 48 |blooper | ![blooper](img/script/tile/blooper.png) | 
  | 52 |wiggler | ![wiggler](img/script/tile/wiggler.png) | 
  | 56 |cheep_cheep | ![cheep_cheep](img/script/tile/cheep_cheep.png) | 
  | 57 |muncher | ![muncher](img/script/tile/muncher.png) | 
  | 58 |rocky_wrench | ![rocky_wrench](img/script/tile/rocky_wrench.png) | 
  | 60 |lava_bubble | ![lava_bubble](img/script/tile/lava_bubble.png) | 
  | 61 |chain_comp | ![chain_comp](img/script/tile/chain_comp.png) | 
  | 63 |ice_block | ![ice_block](img/script/tile/ice_block.png) | 
  | 99 |on_off_switch | ![on_off_switch](img/script/tile/on_off_switch.png) | 
  | 100 |dotted_line_block | ![dotted_line_block](img/script/tile/dotted_line_block.png) | 
  | 102 |monty_mole | ![monty_mole](img/script/tile/monty_mole.png) | 
  | 103 |fish_bones | ![fish_bones](img/script/tile/fish_bones.png) | 
  :オブジェクトとIDの関係表 {#tbl:objectTable}
  
#### Json to Image

  レベルを画像に変換も可能にした.
  画像に変換できることでオブジェクトの配置が視覚的に判別可能になる.
  また,今回のモデルの学習時には使用しなかったが,入力として画像を用いた生成の際にも使用できる.
  
  画像生成の手法はレベルを表現したJsonのオブジェクト情報からそれぞれのオブジェクトの
  スプライトを配置し描画を行う.
  スプライトは事前にゲームと同等のスプライトを用意した.
  
#### Json to ObjectMap

Volzsら[@mario-gan]の研究で使用していた生成モデルであるDCGANに用いた表現をレベル表現を参考に
ObjectMapと呼ぶフォーマットを定義した.
ObjectMapは(オブジェクトの数$\times$ 高さ$\times$ 幅)の3次元で表現されるフォーマットである.

これは位置x,yにおける
オブジェクトの配置を表現したものである.

さらに,smm2のレベル基本的に横長に表現されているため
モデルの入力としては正方形であることが望ましい.
このため,実際のレベルを一定の幅ごとに分割し正方形になるよう,分割,パディングを行った.


[@fig:level2objectmap]にレベル分割,ObjectMapに変換の図を示す.
[@fig:level2objectmap]の
チャンネルはレベル上に配置されるオブジェクトの種類の数に等しい.

![レベルからオブジェクトへの変換](img/level2ObjectMap.png){#fig:level2objectmap}

\
