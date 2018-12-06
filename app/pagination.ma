[
  [total:=, size:=, current:=]=>
    {
      max: #ceil(total? / size?),
      [
        : row middle,
        width: center,
        style: bold,
        {
          active: current? > 1,
          [
            style: 20,
            hover: ,
            fill: 0 0 (active?, hover?, 90, => 100),
            color: (active?, 1 45 47, => 0 0 60),
            pad: 0 8 4,
            round: 3,
            click: current?,
            value: (active?, current? - 1, => 1),
            '‹,
          ],
        },
        ::
          max?
            .#range
            .[
              v=>>
                [
                  hover: ,
                  fill: (v? == current?, 1 45 47, => 0 0 (hover?, 90, => 100)),
                  color: (v? == current?, 0 0 100, => 1 45 47),
                  pad: 5 7,
                  round: 3,
                  click: current?,
                  value: v?,
                  v?,
                ],
            ],
        {
          active: current? < max?,
          [
            style: 20,
            hover: ,
            fill: 0 0 (active?, hover?, 90, => 100),
            color: (active?, 1 45 47, => 0 0 60),
            pad: 0 8 4,
            round: 3,
            click: current?,
            value: (active?, current? + 1, => max?),
            '›,
          ],
        },
      ],
    },
]