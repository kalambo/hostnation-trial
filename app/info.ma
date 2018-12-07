[
  v=>
    [
      gap: 15,
      pad: 10,
      [
        style: 20 bold,
        {v?.First name} {v?.Last name},
      ],
      [
        : table,
        style: 14,
        (
          {v?.Address, v?.Postcode},
          [
            pad: 5,
            [style: bold, Address':],
            {v?.Address}', {v?.Postcode},
          ],
        ),
        (v?.Sex, [pad: 5, [style: bold, Sex':], v?.Sex]),
        (
          v?.Ready,
          [
            pad: 5,
            [style: bold, Ready':],
            (v?.Ready, Yes, => No),
          ],
        ),
        (v?.Match, [pad: 5, [style: bold, Match':], v?.Match]),
        (v?.Age, [pad: 5, [style: bold, Age':], v?.Age]),
      ],
    ],
]