[
  #title(Matching Dashboard \| HostNation),
  style: Lato 14,
  color: 0 0 20,
  pad: 50,
  #loggedIn
    [
      : login?,
      =>
        {
          refugee: ,
          refugee?
            [
              :
                {
                  data:
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
                                  \((
                                    #duration(v?.Created at - @now),
                                  )\),
                              Address: (v?.Address)\, (v?.Postcode),
                            ],
                          ),
                      ]
                      .[v=>> :: [v?]],
                  [
                    gap: 40,
                    header? [title: Select referral],
                    table?
                      [
                        data:=?,
                        fields:
                          [
                            Created at,
                            First name,
                            Last name,
                            Address,
                            Match,
                          ],
                        click: refugee?,
                        paging: true,
                      ],
                  ],
                },
              =>
                {
                  data:
                    #data
                      .Befrienders
                      .[
                        v=>>
                          (
                            !v?.Match,
                            !v?.Archived,
                            v?.Map address,
                            [
                              :: v?,
                              Created at:
                                (#time(v?.Created at))
                                  \((
                                    #duration(v?.Created at - @now),
                                  )\),
                              Address: (v?.Address)\, (v?.Postcode),
                              Distance: refugee?.Map address - v?.Map address,
                            ],
                          ),
                      ]
                      .[v=>> v?.Distance: v?]
                      .[v=>> :: [[:: v?, Distance: (#round(v?.Distance)) km]]]
                      .[k=> v=> :: (k? <= 10, [v?])],
                  [
                    gap: 40,
                    header?
                      [
                        title: (refugee?.First name) (refugee?.Last name),
                        back: refugee?,
                      ],
                    table?
                      [
                        data:=?,
                        fields:
                          [
                            Distance,
                            Created at,
                            First name,
                            Last name,
                            Address,
                          ],
                      ],
                    [
                      : map,
                      [
                        position: refugee?.Map address,
                        icon: star,
                        color: 27 90 (refugee?.Sex == Male, 80, => 90),
                      ],
                      ::
                        data?
                          [
                            v=>>
                              [
                                position: v?.Map address,
                                icon: star,
                                color: 73 50 (v?.Sex == Male, 70, => 80),
                              ],
                          ],
                    ],
                  ],
                },
            ],
        },
    ],
]