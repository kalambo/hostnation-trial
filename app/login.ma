{
  auth: [submit: , password: ],
  loading: #login(auth?),
  [
    width: 600,
    pad: 100 50,
    gap: 40,
    [
      style: 40 bold center,
      color: 1 45 47,
      HostNation,
    ],
    [
      : row,
      style: 18,
      enter: auth?.submit,
      {
        focus: true,
        [
          hover: ,
          fill: (focus?, 1 45 47, => 0 0 70),
          pad: 1,
          [
            focus:=?,
            fill:
              (loading?, 0 0 95, => ({focus?, hover?}, 1 45 107, => 0 0 100)),
            pad: 9,
            style: password,
            :: (!loading?, [input: auth?.password]),
          ],
        ],
      },
      [
        hover: ,
        fill: 1 45 ({hover?, loading?}, 40, => 47),
        color: 0 0 100,
        pad: 10,
        :: (!loading?, [click: auth?.submit]),
        width: 100,
        style: center,
        Log in,
      ],
    ],
  ],
}