import { createMethod, toData } from 'maraca';
import * as webfont from 'webfontloader';

webfont.load({ google: { families: ['Lato:400,700'] } });

const tokenListeners: any = [];
const setToken = token => {
  if (!token) window.sessionStorage.removeItem('authToken');
  else window.sessionStorage.setItem('authToken', token);
  tokenListeners.forEach(l => l(token));
};
const withToken = listener => {
  tokenListeners.push(listener);
  return {
    initial: window.sessionStorage.getItem('authToken'),
    stop: () => tokenListeners.splice(tokenListeners.indexOf(listener), 1),
  };
};

const authEndpoint =
  'https://us-central1-kalambo-platform.cloudfunctions.net/auth';
const dataEndpoint =
  'https://us-central1-kalambo-platform.cloudfunctions.net/hostnation-data';

// light: female, dark: male

// RED (unready)
// 12 85 53
// 12 64 37

// YELLOW (refugee)
// 27 90 80/90

// GREEN (matched)
// 38 88 74
// 38 71 55

// BLUE (ready)
// 73 50 70/80

// PURPLE (ready, secondary)
// 84 62 57
// 85 95 38

export default (create, indexer) => ({
  loggedIn: create(indexer(), ({ output }) => {
    const set = () => setToken(null);
    const { initial, stop } = withToken(token =>
      output({ ...toData(!!token), set }),
    );
    return { initial: { ...toData(!!initial), set }, stop };
  }),
  login: createMethod(
    create,
    ({ initial, output }) => {
      let prev = initial;
      return {
        initial: toData(null),
        update: value => {
          if (
            prev.value.values.submit.value !==
              value.value.values.submit.value &&
            value.value.values.password.value.value
          ) {
            output(toData(true));
            (async () => {
              try {
                const token = await (await fetch(authEndpoint, {
                  method: 'POST',
                  headers: new Headers({ 'Content-Type': 'application/json' }),
                  body: JSON.stringify({
                    username: 'info@hostnation.org.uk',
                    password: value.value.values.password.value.value,
                  }),
                })).text();
                if (token) setToken(token);
              } catch {}
              output(toData(null));
            })();
          }
          prev = value;
        },
      };
    },
    true,
  ),
  data: create(indexer(), ({ output }) => {
    const load = async token => {
      if (token) {
        const result = await fetch(dataEndpoint, {
          method: 'POST',
          headers: new Headers({
            Authorization: `Bearer ${token}`,
            'Content-Type': 'application/json',
          }),
          body: JSON.stringify({}),
        });
        if (result.ok) output(toData(await result.json()));
      }
    };
    const { initial, stop } = withToken(token => {
      output({
        type: 'list',
        value: { indices: [], values: {}, other: () => [{ type: 'nil' }] },
      });
      load(token);
    });
    load(initial);
    return {
      initial: {
        type: 'list',
        value: { indices: [], values: {}, other: () => [{ type: 'nil' }] },
      },
      stop,
    };
  }),
});
