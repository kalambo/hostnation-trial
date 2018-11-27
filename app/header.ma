[
  [title:=, back:=]=>
    [
      : row,
      [
        gap: 5,
        (
          back?,
          [
            style: 16 bold,
            color: 1 45 47,
            click: back?,
            fill: 0 0 100,
            pad: 0 0 5 5,
            width: left,
            "« Back",
          ],
        ),
        [style: 40 bold, title?],
      ],
      [
        hover: ,
        style: 20 bold center,
        color: 0 0 100,
        pad: 10,
        round: 3,
        width: 150,
        fill: 1 45 (hover?, 40, => 47),
        click: #loggedIn,
        Log out,
      ],
    ],
]