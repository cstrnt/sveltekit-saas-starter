// See https://kit.svelte.dev/docs/types#app

import type { db } from '$lib/server/db/client';

// for information about these interfaces
declare global {
	namespace App {
		// interface Error {}
		interface Locals {
			db: typeof db;
		}
		// interface PageData {}
		// interface Platform {}
	}
}

export {};
