import * as dotenv from 'dotenv';
dotenv.config();

import { stores, users } from './schema';
import { drizzle } from 'drizzle-orm/postgres-js';
import postgres from 'postgres';
import crypto from 'crypto';
import { eq } from 'drizzle-orm';

const client = postgres(process.env.DATABASE_URL!);
const db = drizzle(client);

const userEmail = 'info@my-store.com';
try {
	await db
		.insert(users)
		.values({
			id: crypto.randomUUID(),
			email: userEmail,
			name: 'Peter Parker'
		})
		.onConflictDoNothing();

	const [user] = await db.select().from(users).where(eq(users.email, userEmail)).limit(1);

	await db
		.insert(stores)
		.values({
			id: '1',
			ownerId: user.id,
			name: 'Creative Studio Copy Shop Köln',
			street: 'Aachener Str.',
			streetNumber: '525',
			city: 'Köln',
			postalCode: '50933',
			latituide: 50.9365479,
			longitude: 6.8979269,
			created_at: new Date(),
			phone: '+49 123 456 789',
			country: 'DE',
			email: 'info@my-store.com'
		})
		.onConflictDoNothing();

	await db
		.insert(stores)
		.values({
			id: '2',
			ownerId: user.id,
			name: 'Digitaldruck-Punkt',
			street: 'Habsburgerring',
			streetNumber: '1',
			city: 'Köln',
			postalCode: '50674',
			latituide: 50.93483,
			longitude: 6.93891,
			created_at: new Date(),
			phone: '+49 123 456 789',
			country: 'DE',
			email: 'super@print.de'
		})
		.onConflictDoNothing();
} catch (e) {
	console.error(e);
}
console.log('Seed complete');
process.exit(0);
