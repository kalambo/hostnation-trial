[
  #title(Matching Dashboard '| HostNation),
  style: Lato 14,
  color: 0 0 20,
  pad: 50,
  #loggedIn
    [
      : login?,
      =>
        {
          refugees:
            #data
              .Refugees
              .[v=>> -v?.Created at: v?]
              .[
                v=>>
                  (
                    v?.Map address,
                    [
                      :: v?,
                      Created at:
                        (#time(v?.Created at))
                          '({#duration(@now - v?.Created at)}
                          ago'),
                      Age: #duration(@now - v?.DOB),
                    ],
                  ),
              ]
              .[v=>> :: [v?]],
          refugee: ,
          refugee?
            [
              :
                [
                  gap: 40,
                  header? [title: Select referral],
                  table?
                    [
                      data: refugees?,
                      fields:
                        [
                          Created at,
                          First name,
                          Last name,
                          Age,
                          Sex,
                          Country,
                          English skill,
                          Match,
                        ],
                      click: refugee?,
                      paging: true,
                    ],
                ],
              =>
                {
                  befrienders:
                    #data
                      .Befrienders
                      .[
                        v=>>
                          (
                            !v?.Archived,
                            v?.Map address,
                            [
                              :: v?,
                              Created at:
                                (#time(v?.Created at))
                                  '({#duration(@now - v?.Created at)}
                                  ago'),
                              Age: #duration(@now - v?.DOB),
                              Distance: refugee?.Map address - v?.Map address,
                            ],
                          ),
                      ]
                      .[v=>> v?.Distance: v?]
                      .[v=>> :: [[:: v?, Distance: (#round(v?.Distance)) km]]],
                  top:
                    befrienders?
                      .[k=> v=> :: (!v?.Match, [v?])]
                      .[k=> v=> :: (k? <= 10, [v?])]
                      .[v=>> [:: v?, Ready: (v?.Ready, Yes, => No)]],
                  [
                    gap: 40,
                    header?
                      [
                        title: {refugee?.First name} {refugee?.Last name},
                        back: refugee?,
                      ],
                    table?
                      [
                        data: top?,
                        fields:
                          [
                            Distance,
                            Created at,
                            First name,
                            Last name,
                            Age,
                            Languages,
                            Children,
                            Ready,
                          ],
                      ],
                    [
                      : map,
                      ::
                        befrienders?
                          .[
                            k=> v=>
                              {
                                inTop: top?.[t=>> :: t?.Id == v?.Id].1,
                                [
                                  position: v?.Map address,
                                  icon: (v?.Ready, star, => question),
                                  color:
                                    (
                                      v?.Match,
                                      40 100 (v?.Sex == Male, 55, => 70),
                                      =>
                                        (
                                          v?.Ready,
                                          70 100 (v?.Sex == Male, 50, => 70),
                                          => 10 100 (v?.Sex == Male, 40, => 60),
                                        ),
                                    ),
                                  size: (inTop?, 1.75, => 1),
                                  fit: inTop?,
                                  info: info?.v?,
                                ],
                              },
                          ],
                      ::
                        refugees?
                          .[
                            v=>>
                              [
                                position: v?.Map address,
                                icon: star,
                                color: 25 100 (v?.Sex == Male, 75, => 90),
                                size: (v?.Id == refugee?.Id, 1.75, => 1),
                                info: info?.v?,
                              ],
                          ],
                    ],
                  ],
                },
            ],
        },
    ],
]