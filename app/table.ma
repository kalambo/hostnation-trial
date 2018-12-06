[
  [data:=, fields:=, click:=, paging:=]=>
    {
      size: 10,
      page: 1,
      [
        gap: 15,
        (paging?, pagination? [total: data?.#size, size:=?, current: page?]),
        [
          : table,
          [
            style: bold,
            fill: 0 0 85,
            pad: 10,
            round: 3,
            '#,
            :: fields?,
          ],
          ::
            (
              data?,
              (
                  size?
                    .#range
                    .[v=>> ((page? - 1) * size?) + v?]
                    .[v=>> data?.v?],
                )
                [
                  k=> v=>
                    [
                      hover: ,
                      click:=?,
                      value: v?,
                      pad: 10,
                      round: 3,
                      color: (hover?, 0 0 100, => 1 45 47),
                      fill: (hover?, 1 45 47, => 0 0 (k? % 2 == 0, 97, => 150)),
                      [
                        style: bold,
                        color: (hover?, 0 0 100, => 0 0 20),
                        ((page? - 1) * size?) + k?,
                      ],
                      :: fields? [f=>> {v?.f?, '-}],
                    ],
                ],
            ),
        ],
        (paging?, pagination? [total: data?.#size, size:=?, current: page?]),
      ],
    },
]