import { SvelteKitAuth } from '@auth/sveltekit';
import GoogleAuth from '@auth/core/providers/google';
import EmailProvider from '@auth/core/providers/email';
import {
	AUTH_FROM_EMAIL,
	AUTH_SECRET,
	EMAIL_SERVER,
	GOOGLE_CLIENT_ID,
	GOOGLE_CLIENT_SECRET
} from '$env/static/private';
import { DrizzleAdapter } from '@auth/drizzle-adapter';
import { db } from '$lib/server/db/client';
import type { Provider } from '@auth/core/providers';
import { sequence } from '@sveltejs/kit/hooks';

export const handle = sequence(
	SvelteKitAuth({
		adapter: DrizzleAdapter(db),
		secret: AUTH_SECRET,
		trustHost: true,
		providers: [
			EmailProvider({
				server: EMAIL_SERVER,
				from: AUTH_FROM_EMAIL
			}) as Provider,
			GoogleAuth({
				clientId: GOOGLE_CLIENT_ID,
				clientSecret: GOOGLE_CLIENT_SECRET
			})
		]
	}),
	({ event, resolve }) => {
		event.locals.db = db;
		return resolve(event);
	}
);
