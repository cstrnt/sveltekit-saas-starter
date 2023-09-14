<script lang="ts">
	import Button from '$lib/components/ui/button/button.svelte';
	import { signIn, signOut } from '@auth/sveltekit/client';
	import { page } from '$app/stores';
</script>

<div class="container">
	<h1>Welcome to SvelteKit</h1>
	<p>Visit <a href="https://kit.svelte.dev">kit.svelte.dev</a> to read the documentation</p>
	<Button on:click={() => signIn('google')}>Google</Button>
	<Button on:click={() => signIn('email')}>Email</Button>
	{#if $page.data.session}
		<pre>{JSON.stringify($page.data.session, null, 2)}</pre>

		<Button on:click={() => signOut()}>Sign Out</Button>
	{/if}
</div>
