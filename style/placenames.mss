@placenames: #ffffff;
@placenames-light: #ffffff;
@country-labels: #ffffff;
@state-labels: #ffffff;
@county-labels: #ffffff;

#country-names {
  [zoom >= 3][zoom < 5][way_pixels > 1000],
  [zoom >= 5][zoom < 8][way_pixels < 360000] {
    text-name: "[name]";
    text-size: 10;
    text-wrap-width: 18; // 3.5 em
    text-line-spacing: -1.5; // -0.15 em
    text-margin: 7.0; // 0.7 em
    [zoom >= 4] {
      text-size: 11;
      text-wrap-width: 20; // 3.6 em
      text-line-spacing: -1.4; // -0.13 em
      text-margin: 7.7; // 0.7 em
    }
    [zoom >= 5] {
      text-size: 12;
      text-wrap-width: 23; // 3.7 em
      text-line-spacing: -1.2; // -0.10 em
      text-margin: 8.4; // 0.7 em
      text-transform: uppercase;
    }
    [zoom >= 7] {
      text-size: 13;
      text-wrap-width: 25; // 3.8 em
      text-line-spacing: -1.0; // -0.08 em
      text-margin: 9.1; // 0.7 em
      text-transform: uppercase;
    }
    text-fill: @country-labels;
    text-face-name: @bold-fonts;
    text-halo-fill: @standard-halo-fill;
    text-halo-radius: @standard-halo-radius * 1.5;
    text-character-spacing: 0.5;
  }
}

#state-names {
  [zoom >= 4][zoom < 7][way_pixels > 2000],
  [zoom >= 6][way_pixels > 2000][way_pixels < 196000] {
    text-name: "[name]";
    text-size: 12;
    text-wrap-width: 18; // 3.5 em
    text-line-spacing: -1.5; // -0.15 em
    text-margin: 7.0; // 0.7 em
    text-fill: @state-labels;
    text-face-name: @bold-fonts;
    text-halo-fill: @standard-halo-fill;
    text-halo-radius: @standard-halo-radius * 1.5;
    text-placement: interior;
    text-transform: uppercase;
/*
    [zoom >= 7] {
      text-size: 11;
      text-wrap-width: 20; // 3.6 em
      text-line-spacing: -1.4; // -0.13 em
      text-margin: 7.7; // 0.7 em
    }
    [zoom >= 9] {
      text-size: 12;
      text-wrap-width: 23; // 3.7 em
      text-line-spacing: -1.2; // -0.10 em
      text-margin: 8.4; // 0.7 em
    }
*/
    [zoom >= 8] {
      text-size: 14;
      text-wrap-width: 25; // 3.8 em
      text-line-spacing: -1.0; // -0.08 em
      text-margin: 9.1; // 0.7 em
    }
    [zoom >= 12] {
      text-size: 15;
      text-wrap-width: 25; // 3.8 em
      text-line-spacing: -1.0; // -0.08 em
      text-margin: 9.1; // 0.7 em
    }
  }
}

#capital-names {
//[zoom >= 4][zoom < 8][population > 600000],
  [zoom >= 6][zoom < 8] {
    shield-file: url('symbols/place/place-capital-6.svg');
    shield-text-dx: 6;
    shield-text-dy: 6;
    shield-name: '[name]';
    shield-face-name: @bold-fonts;
    shield-fill: @placenames;
    shield-size: 10;
    shield-wrap-width: 30; // 2.7 em
    shield-line-spacing: -1.6; // -0.15 em
    shield-margin: 7.7; // 0.7 em
    shield-halo-fill: @standard-halo-fill;
    shield-halo-radius: @standard-halo-radius * 1.5;
    shield-placement-type: simple;
    shield-placements: 'S,N,E,W';
    [dir = 1] {
      shield-placements: 'N,S,E,W';
    }
    shield-unlock-image: true;

    [zoom >= 5] {
      shield-wrap-width: 45; // 4.1 em
      shield-line-spacing: -1.1; // -0.10 em
    }
/*
    [zoom >= 6] {
      shield-size: 12;
      shield-wrap-width: 60; // 5.0 em
      shield-line-spacing: -0.6; // -0.05 em
      shield-margin: 8.4; // 0.7 em
    }
*/
    [zoom >= 7] {
      shield-file: url('symbols/place/place-capital-8.svg');
      shield-text-dx: 7;
      shield-text-dy: 7;
    }
  }
  [zoom >= 6] {
    text-name: '[name]';
    text-face-name: @bold-fonts;
    text-fill: @placenames;
    text-size: 14;
    text-wrap-width: 33; // 5.0 em
    text-line-spacing: -0.65; // -0.05 em
    text-margin: 9.1; // 0.7 em
    text-halo-fill: @standard-halo-fill;
    text-halo-radius: @standard-halo-radius * 1.5;

    [zoom >= 10] {
      text-size: 14;
      text-wrap-width: 35; // 5.0 em
      text-line-spacing: -0.70; // -0.05 em
      text-margin: 9.8; // 0.7 em
    }
    [zoom >= 11] {
      text-size: 15;
      text-wrap-width: 38; // 5.0 em
      text-line-spacing: -0.75; // -0.05 em
      text-margin: 10.5; // 0.7 em
    }
    [zoom >= 14] {
      text-size: 15;
      text-wrap-width: 38; // 5.0 em
      text-line-spacing: -0.75; // -0.05 em
      text-margin: 10.5; // 0.7 em
      text-transform: uppercase;
    }
  }
}

#placenames-medium::high-importance {
  [category = 1][zoom < 14] {
    [zoom >= 5][zoom < 6][score >= 3000000],
    [zoom >= 6][zoom < 9][score >= 600000] {
      shield-file: url('symbols/place/place-4.svg');
      shield-text-dx: 4;
      shield-text-dy: 4;
      shield-name: '[name]';
      shield-face-name: @bold-fonts;
      shield-fill: @placenames;
      shield-size: 11;
      shield-wrap-width: 30; // 2.7 em
      shield-line-spacing: -1.65; // -0.15 em
      shield-margin: 7.7; // 0.7 em
      shield-halo-fill: @standard-halo-fill;
      shield-halo-radius: @standard-halo-radius * 1.5;
      shield-placement-type: simple;
      shield-placements: 'S,N,E,W';
      [dir = 1] {
        shield-placements: 'N,S,E,W';
      }
      shield-unlock-image: true;

      [zoom >= 6] {
        shield-wrap-width: 45; // 4.1 em
        shield-line-spacing: -1.1; // -0.10 em
      }
      [zoom >= 7] {
        shield-size: 12;
        shield-wrap-width: 60; // 5.0 em
        shield-line-spacing: -0.6; // -0.05 em
        shield-margin: 8.4; // 0.7 em

        shield-file: url('symbols/place/place-6.svg');
        shield-text-dx: 5;
        shield-text-dy: 5;
      }
      [zoom >= 8] {
        shield-file: url('symbols/place/place-6-z7.svg');
      }
    }
    [zoom >= 8][score >= 400000] {
      text-name: '[name]';
      text-face-name: @bold-fonts;
      text-fill: @placenames;
      text-size: 14;
      text-wrap-width: 35; // 5.0 em
      text-line-spacing: -0.7; // -0.05 em
      text-margin: 9.8; // 0.7 em
      text-halo-fill: @standard-halo-fill;
      text-halo-radius: @standard-halo-radius * 1.5;
      [zoom >= 10] {
        text-size: 13;
        text-wrap-width: 38; // 5.0 em
        text-line-spacing: -0.75; // -0.05 em
        text-margin: 10.5; // 0.7 em
      }
      [zoom >= 15] {
       text-size: 15;
       text-wrap-width: 38; // 5.0 em
       text-line-spacing: -0.75; // -0.05 em
       text-margin: 10.5; // 0.7 em
       text-transform: uppercase;
      }
    }
  }
}

#placenames-medium::medium-importance {
  [category = 1][score < 400000][zoom < 16] {
    [zoom >= 6][zoom < 9][score >= 70000],
    [zoom >= 8][zoom < 9] {
      shield-file: url('symbols/place/place-4.svg');
      shield-text-dx: 4;
      shield-text-dy: 4;
      shield-name: "[name]";
      shield-size: 10;
      shield-fill: @placenames;
      shield-face-name: @bold-fonts;
      shield-halo-fill: @standard-halo-fill;
      shield-halo-radius: @standard-halo-radius * 1.5;
      shield-wrap-width: 30; // 3.0 em
      shield-line-spacing: -1.5; // -0.15 em
      shield-margin: 7.0; // 0.7 em
      shield-placement-type: simple;
      shield-placements: 'S,N,E,W';
      [dir = 1] {
        shield-placements: 'N,S,E,W';
      }
      shield-unlock-image: true;
      [zoom >= 7] {
        shield-file: url('symbols/place/place-4-z7.svg');
      }
    }
    [zoom >= 8] {
      text-name: "[name]";
      text-size: 10;
      text-fill: @placenames;
      text-face-name: @bold-fonts;
      text-halo-fill: @standard-halo-fill;
      text-halo-radius: @standard-halo-radius * 1.5;
      text-wrap-width: 20; // 4.0 em
      text-line-spacing: -1.0; // -0.10 em
      text-margin: 7.0; // 0.7 em
      [zoom >= 10] {
        text-size: 11;
        text-wrap-width: 30; // 5.0 em
        text-line-spacing: -0.6; // -0.05 em
        text-margin: 8.4; // 0.7 em
      }
      [zoom >= 11] {
        text-size: 13;
        text-wrap-width: 33; // 5.0 em
        text-line-spacing: -0.65; // -0.05 em
        text-margin: 9.1; // 0.7 em
      }
      [zoom >= 12] {
        text-size: 14;
        text-wrap-width: 35; // 5.0 em
        text-line-spacing: -0.7; // -0.05 em
        text-margin: 9.8; // 0.7 em
      }
      [zoom >= 15] {
        text-size: 15;
        text-wrap-width: 38; // 5.0 em
        text-line-spacing: -0.7; // -0.05 em
        text-margin: 10.5; // 0.7 em
        text-transform: uppercase;
      }
    }
  }
}

#placenames-medium::low-importance {
  [category = 2] {
    [zoom >= 10][zoom < 16] {
      text-name: "[name]";
      text-size: 10;
      text-fill: @placenames;
      text-face-name: @bold-fonts;
      text-halo-fill: @standard-halo-fill;
      text-halo-radius: @standard-halo-radius * 1.5;
      text-wrap-width: 23; // 4.5 em
      text-line-spacing: -0.8; // -0.08 em
      text-margin: 7; // 0.7 em
      [zoom >= 12] {
        text-size: 11;
        text-wrap-width: 28; // 5.0 em
        text-line-spacing: -0.55; // -0.05 em
        text-margin: 7.7; // 0.7 em
      }
      [zoom >= 13] {
        text-size: 13;
        text-wrap-width: 33; // 5.0 em
        text-line-spacing: -0.65; // -0.05 em
        text-margin: 8.4; // 0.7 em
      }
      [zoom >= 15] {
        text-size: 15;
        text-wrap-width: 38; // 5.0 em
        text-line-spacing: -0.75; // -0.05 em
        text-margin: 10.5; // 0.7 em
      }
    }
  }
}

#placenames-small::suburb {
  [place = 'suburb'][zoom >= 13][zoom < 17] {
    text-name: "[name]";
    text-size: 11;
    text-fill: @placenames;
    text-face-name: @bold-fonts;
    text-halo-fill: @standard-halo-fill;
    text-halo-radius: @standard-halo-radius * 1.5;
    text-wrap-width: 28; // 5.0 em
    text-line-spacing: -0.55; // -0.05 em
    text-margin: 7.7; // 0.7 em
    [zoom >= 14] {
      text-size: 12;
      text-wrap-width: 30; // 5.0 em
      text-line-spacing: -0.60; // -0.05 em
      text-margin: 8.4; // 0.7 em
    }
    [zoom >= 15] {
      text-size: 14;
      text-wrap-width: 35; // 5.0 em
      text-line-spacing: -0.70; // -0.05 em
      text-margin: 9.8; // 0.7 em
      text-fill: @placenames-light;
      text-halo-fill: black;
      text-transform: uppercase;
    }
    [zoom >= 16] {
      text-size: 15;
      text-wrap-width: 38; // 5.0 em
      text-line-spacing: -0.75; // -0.05 em
      text-margin: 10.5; // 0.7 em
      text-transform: uppercase;
    }
  }
}

#placenames-small::village {
  [place = 'village'] {
    [zoom >= 13][zoom < 17] {
      text-name: "[name]";
      text-size: 10;
      text-fill: @placenames;
      text-face-name: @bold-fonts;
      text-halo-fill: @standard-halo-fill;
      text-halo-radius: @standard-halo-radius * 1.5;
      text-wrap-width: 25; // 5.0 em
      text-line-spacing: -0.50; // -0.05 em
      text-margin: 7.0; // 0.7 em
      [zoom >= 13] {
        text-size: 11;
        text-wrap-width: 28; // 5.0 em
        text-line-spacing: -0.55; // -0.05 em
        text-margin: 7.7; // 0.7 em
      }
      [zoom >= 14] {
        text-fill: @placenames-light;
        text-halo-fill: black;
        text-size: 13;
        text-wrap-width: 33; // 5.0 em
        text-line-spacing: -0.65; // -0.05 em
        text-margin: 9.1; // 0.7 em
      }
      [zoom >= 15] {
        text-size: 14;
        text-wrap-width: 35; // 5.0 em
        text-line-spacing: -0.70; // -0.05 em
        text-margin: 9.8; // 0.7 em
      }
      [zoom >= 16] {
        text-size: 15;
        text-wrap-width: 38; // 5.0 em
        text-line-spacing: -0.75; // -0.05 em
        text-margin: 10.5; // 0.7 em
      }
    }
  }
}

#placenames-small::quarter {
  [place = 'quarter'] {
    [zoom >= 14][zoom < 17] {
      text-name: "[name]";
      text-fill: @placenames;
      text-face-name: @bold-fonts;
      text-halo-fill: @standard-halo-fill;
      text-halo-radius: @standard-halo-radius * 1.5;
      [zoom >= 14] {
        text-halo-fill: black;
        text-size: 11;
        text-wrap-width: 28; // 5.0 em
        text-line-spacing: -0.55; // -0.05 em
        text-margin: 7.7; // 0.7 em
      }
      [zoom >= 15] {
        text-fill: @placenames-light;
        text-size: 12;
        text-wrap-width: 30; // 5.0 em
        text-line-spacing: -0.60; // -0.05 em
        text-margin: 8.4; // 0.7 em
      }
      [zoom >= 16] {
        text-size: 14;
        text-wrap-width: 35; // 5.0 em
        text-line-spacing: -0.70; // -0.05 em
        text-margin: 9.8; // 0.7 em
      }
    }
  }
  [place = 'hamlet'] {
    [zoom >= 14][zoom < 18] {
      text-name: "[name]";
      text-fill: @placenames;
      text-face-name: @bold-fonts;
      text-halo-fill: black;
      text-halo-radius: @standard-halo-radius * 1.5;
      [zoom >= 14] {
        text-size: 10;
        text-wrap-width: 28; // 5.0 em
        text-line-spacing: -0.55; // -0.05 em
        text-margin: 7.7; // 0.7 em
      }
      [zoom >= 15] {
        text-size: 11;
        text-fill: @placenames-light;
        text-halo-fill: @standard-halo-fill;
        text-wrap-width: 23; // 4.5 em
        text-line-spacing: -0.8; // -0.08 em
        text-margin: 7.0; // 0.7 em
      }
      [zoom >= 16] {
        text-size: 12;
        text-wrap-width: 30; // 5.0 em
        text-line-spacing: -0.60; // -0.05 em
        text-margin: 8.4; // 0.7 em
        text-fill: @placenames-light;
        text-halo-fill: black;
      }
    }
  }
}

#placenames-small::neighborhood {
  [place = 'neighbourhood'][zoom >= 15][zoom < 20],
  [place = 'isolated_dwelling'][zoom >= 15],
  [place = 'farm'][zoom >= 15] {
    text-name: "[name]";
    text-size: 10;
    text-fill: @placenames;
    text-face-name: @bold-fonts;
    text-halo-fill: @standard-halo-fill;
    text-halo-radius: @standard-halo-radius * 1.5;
    text-wrap-width: 23; // 4.5 em
    text-line-spacing: -0.8; // -0.08 em
    text-margin: 7.0; // 0.7 em
    [zoom >= 16] {
      text-size: 12;
      text-wrap-width: 30; // 5.0 em
      text-line-spacing: -0.60; // -0.05 em
      text-margin: 8.4; // 0.7 em
      text-fill: @placenames-light;
      text-halo-fill: black;
    }
  }
}

#county-names {
  [zoom >= 8][way_pixels > 12000][way_pixels < 196000] {
    [admin_level = '5'][zoom >= 8],
    [admin_level = '6'][zoom >= 10] {
      text-name: "[name]";
      text-size: 12;
      text-wrap-width: 23; // 3.7 em
      text-line-spacing: -1.2; // -0.10 em
      text-margin: 8.4; // 0.7 em
      text-fill: @county-labels;
      text-face-name: @book-fonts;
      text-halo-fill: @standard-halo-fill;
      text-halo-radius: @standard-halo-radius * 1.5;
      text-placement-type: simple;
      text-placements: "S,SE,SW,E,NE,W,NW,N";
      text-transform: uppercase;
      [admin_level = '5'] {
        [zoom >= 10] {
          text-size: 12;
          text-wrap-width: 23; // 3.7 em
          text-line-spacing: -1.2; // -0.10 em
          text-margin: 8.4; // 0.7 em
        }
        [zoom >= 12] {
          text-size: 13;
          text-wrap-width: 25; // 3.8 em
          text-line-spacing: -1.0; // -0.08 em
          text-margin: 9.1; // 0.7 em
        }
      }
    }
  }
}
