<!doctype html>
<html lang="en" class="h-100" data-bs-theme="auto">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="application-name" content="AI Character Editor">
	<meta name="description" content="Create, edit and convert AI character files for CharacterAI, Pygmalion, Text Generation and TavernAI">
	<meta name="version" content="0.5.0">
	<meta name="revision" content="2023-02-06">
	<meta name="author" content="ZoltanAI">
	<meta name="contact" content="Zoltan#8287 on Discord">
	<meta name="license" content="GNU-GPLv3">
	<meta name="color-scheme" content="light dark" />
	<meta name="theme-color" media="(prefers-color-scheme: light)" content="#F8F9FA" />
	<meta name="theme-color" media="(prefers-color-scheme: dark)" content="#2B3035" />
	<meta name="twitter:card" content="summary">
	<meta property="og:title" content="AI Character Editor">
	<meta property="og:description" content="Create, edit and convert AI character files for CharacterAI, Pygmalion, Text Generation and TavernAI">
	<meta property="og:url" content="https://zoltanai.github.io/character-editor/">
	<meta property="og:type" content="website">
	<title>AI Character Editor</title>
	<script>
		(() => {
			'use strict';

			const getTheme = () => localStorage.getItem('theme') ?? (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');

			document.documentElement.setAttribute('data-bs-theme', getTheme());

			window.addEventListener('DOMContentLoaded', () => {
				document.getElementById('theme').addEventListener('click', () => {
					const theme = getTheme() === 'dark' ? 'light' : 'dark';
					localStorage.setItem('theme', theme);
					document.documentElement.setAttribute('data-bs-theme', theme);
				});
			});
		})();
	</script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10/font/bootstrap-icons.min.css">
	<style>
		body{
			background-image: C:/Users/ayush/OneDrive/Desktop/Ai/magic-g1db898374_1920;
		}
		.accordion-button:disabled {
			cursor: not-allowed;
		}

		.bg-drag {
			background-color: var(--bs-accordion-active-bg);
		}

		.border-dotted {
			--bs-border-style: dotted;
		}

		.tooltip {
			--bs-tooltip-max-width: 500px;
		}

		.popover {
			--bs-popover-max-width: 50vw;
			--bs-popover-body-padding-x: 0;
			--bs-popover-body-padding-y: 0.5rem;
			--bs-popover-bg: var(--bs-tertiary-bg);
		}

		.list-group-item {
			--bs-list-group-bg: var(--bs-tertiary-bg);
		}

		textarea {
			resize: none;
		}

		figure div a:hover,
		figure div a.hover {
			background-color: rgba(var(--bs-secondary-color-rgb), 0.3);
		}

		figure div a:hover svg,
		figure div a.hover svg {
			display: block !important;
		}

		i[data-bs-toggle="tooltip"],
		[data-bs-toggle="popover"] * {
			cursor: help;
		}

		@media (min-width: 992px) {
			.border-end-lg {
				border-right: var(--bs-border-width) var(--bs-border-style) var(--bs-border-color) !important;
			}

			.border-bottom-lg-0 {
				border-bottom: 0 !important;
			}
		}
	</style>
</head>

<body class="d-flex flex-column h-100 bg-body-tertiary">
	<main class="flex-shrink-0">
		<div class="container pt-4 pb-5">
			<h1 class="display-1 text-center">AI Character Editor</h1>
			<p class="my-0 lead text-center">Create, edit and convert to and from <a href="https://beta.character.ai/" target="_blank">CharacterAI</a> <a href="https://github.com/0x000011b/characterai-dumper" target="_blank">dumps</a>, <a href="https://github.com/PygmalionAI/gradio-ui" target="_blank">Pygmalion</a>, <a href="https://github.com/oobabooga/text-generation-webui" target="_blank">Text Generation</a> and <a href="https://github.com/TavernAI/TavernAI" target="_blank">TavernAI</a> formats easily</p>
			<p class="lead text-center">Supports both JSON and Character Card image files</p>

			<button id="theme" class="btn btn-outline-secondary position-absolute top-0 end-0 m-4">
				<i class="bi bi-lightbulb"></i>
			</button>

			<div class="container my-5 text-center">
				<div id="site-alert" class="alert alert-warning alert-dismissible show d-none" role="alert">
					None of your data is uploaded or shared, this entire webpage runs locally in your browser!
					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				</div>
			</div>

			<div class="container">
				<div id="accordion" class="accordion border-0">
					<div class="accordion-item">
						<h2 class="accordion-header">
							<button class="accordion-button shadow-none fs-5" type="button" data-bs-toggle="collapse" data-bs-target="#accordion-load">
								<i class="bi bi-file-earmark-plus flex-shrink-0 me-2"></i> Load
							</button>
						</h2>

						<div id="accordion-load" class="accordion-collapse collapse show" data-bs-parent="#accordion">
							<div class="accordion-body text-center p-0">
								<div class="container">
									<div class="row">
										<div class="col-6 py-5 position-relative">
											<form id="load-form">
												<i class="bi bi-cloud-upload display-2 text-primary"></i>

												<p class="my-2">Drag &amp; drop a JSON or image file here<br><i>or</i></p>

												<label for="load" class="btn btn-primary stretched-link">Choose file...</label>
												<input id="load" class="position-absolute invisible" type="file" accept="application/json, image/png">
											</form>
										</div>

										<div class="col-6 py-5 position-relative border-start">
											<i class="bi bi-file-earmark-plus display-2 text-primary"></i>

											<p class="my-2">Start from scratch and create a new character<br><br></p>

											<button id="create" type="button" class="btn btn-primary stretched-link">New character</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="accordion-item">
						<h2 class="accordion-header">
							<button class="accordion-button collapsed shadow-none fs-5" type="button" data-bs-toggle="collapse" data-bs-target="#accordion-edit" disabled autocomplete="off">
								<i class="bi bi-pencil flex-shrink-0 me-2"></i> Edit
							</button>
						</h2>

						<div id="accordion-edit" class="accordion-collapse collapse" data-bs-parent="#accordion">
							<div class="accordion-body">
								<div class="container">
									<div class="row">
										<div id="edit-alert-characterai-history" class="my-2 alert alert-warning alert-dismissible show d-none" role="alert">
											<p class="fw-semibold">You have loaded a CharacterAI chat history file</p>
											<p class="mb-0">CharacterAI chat history files do not contain character Example Messages, so where possible use a CharacterAI character definition file!<br>If the character you want to use is your own or the character settings are public, then you will get better results <a id="edit-alert-characterai-history-link" class="alert-link" href="#" target="_blank">downloading a definition dump</a> instead.</p>
											<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
										</div>
									</div>

									<div class="row my-3">
										<div id="edit-details" class="col-12 col-md-5 col-lg-4 col-xl-3">
											<figure class="mb-4 figure w-100 text-center">
												<div class="position-relative w-100 h-100">
													<input id="image" class="position-absolute invisible" type="file" accept="image/*">

													<a id="edit-image-add" href="" class="position-absolute top-0 start-0 w-100 h-100 d-inline-block rounded stretched-link z-3">
														<svg class="position-absolute top-50 start-50 translate-middle w-25 h-25 d-none" xmlns="http://www.w3.org/2000/svg" fill="var(--bs-secondary-bg)" viewBox="0 0 16 16">
															<path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3v-3z" />
														</svg>
													</a>

													<svg id="edit-image-placeholder" class="img-thumbnail w-100 bg-body-tertiary" xmlns="http://www.w3.org/2000/svg" width="5" height="6" viewBox="0 0 16 16" fill="var(--bs-secondary-bg)">
														<path d="M8.002 5.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z" />
														<path d="M12 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zM3 2a1 1 0 0 1 1-1h8a1 1 0 0 1 1 1v8l-2.083-2.083a.5.5 0 0 0-.76.063L8 11 5.835 9.7a.5.5 0 0 0-.611.076L3 12V2z" />
													</svg>

													<img id="edit-image" class="img-thumbnail w-100 bg-body-tertiary d-none" src="#" alt="">
												</div>

												<figcaption id="edit-image-details" class="figure-caption d-inline-flex mt-1 d-none"></figcaption>
												<i class="bi bi-info-circle fs-5 d-inline-block ms-1 align-top text-success d-none" data-bs-toggle="tooltip" data-bs-custom-class="tooltip-help" data-bs-title="Character Card images should be 400 x 600px (2:3)"></i>
											</figure>

											<div id="edit-original" class="container p-3 border rounded d-none">
												<div class="row text-center">
													<h3 class="h5">Original File</h3>
												</div>

												<div class="row mt-3">
													<div class="col-auto fst-italic">Name</div>
													<div id="edit-original-name" class="col-auto ms-auto text-end text-break text-wrap"></div>
												</div>

												<div class="row mt-3">
													<div class="col-auto fst-italic">Format</div>
													<div id="edit-original-format" class="col-auto ms-auto text-end text-break text-wrap"></div>
												</div>

												<div class="row mt-3">
													<div class="col-auto fst-italic">Tokens</div>
													<div id="edit-original-tokens" class="col-auto ms-auto text-end"></div>
												</div>

												<div class="row mt-3">
													<div class="col-auto fst-italic">Size</div>
													<div id="edit-original-size" class="col-auto ms-auto text-end"></div>
												</div>

												<div class="row mt-3">
													<div class="col-auto fst-italic">Last Modified</div>
													<div class="col-auto ms-auto text-end">
														<time id="edit-original-modified" class="border-bottom border-dotted border-primary" datetime="" data-bs-toggle="tooltip" data-bs-title=" "></time>
													</div>
												</div>
											</div>

											<div id="edit-metadata-cai" class="container mt-4 p-3 border rounded d-none">
												<div class="row text-center">
													<h3 class="h5">CharacterAI Metadata</h3>
												</div>

												<div class="row mt-3 d-none">
													<div class="col-auto fst-italic">Character</div>
													<div class="col-auto ms-auto text-end">
														<a id="edit-metadata-cai-link" href="#" target="_blank"></a>
													</div>
												</div>

												<div class="row mt-3 d-none">
													<div class="col-auto fst-italic">Visibility</div>
													<div id="edit-metadata-cai-visibility" class="col-auto ms-auto text-end"></div>
												</div>

												<div class="row mt-3 d-none">
													<div class="col-auto fst-italic">Interactions</div>
													<div id="edit-metadata-cai-interactions" class="col-auto ms-auto text-end"></div>
												</div>

												<div class="row mt-3 d-none">
													<div class="col-auto fst-italic">Categories</div>
													<div id="edit-metadata-cai-categories" class="col-auto ms-auto text-end"></div>
												</div>

												<div class="row mt-3 d-none">
													<div class="col-auto fst-italic">Image Generation</div>
													<div id="edit-metadata-cai-image-generation" class="col-auto ms-auto text-end"></div>
												</div>
											</div>
										</div>

										<div class="col-12 col-md-7 col-lg-8 col-xl-9">
											<form class="needs-validation" autocomplete="off" novalidate>
												<div class="mb-3">
													<span class="d-inline-block" tabindex="0" data-bs-toggle="popover">
														<label for="edit-name" class="form-label fw-semibold">Name</label>
														<i class="bi bi-info-circle fs-5 text-primary"></i>
														<ul class="list-group list-group-flush d-none">
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-check text-success"></i> Pygmalion</span> &middot; Character Name
																<p class="mb-0">The character's name</p>
															</li>
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-check text-success"></i> Text Generation</span> &middot; Bot's name
															</li>
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-check text-success"></i> TavernAI</span> &middot; <em>Used but uneditable</em>
															</li>
															<li class="list-group-item d-none">
																<span class="fw-semibold"><i class="bi bi-check text-success"></i> KoboldAI</span> &middot; Name
															</li>
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-check text-success"></i> CharacterAI</span> &middot; Name
																<p class="mb-0">This will be the name your Character uses in chat</p>
															</li>
														</ul>
													</span>

													<input type="text" class="form-control" id="edit-name" required>
													<label for="edit-name" class="form-label float-end mt-1 small text-secondary"></label>
													<div class="invalid-feedback">
														Name is required by all formats
													</div>
												</div>

												<div class="mb-3">
													<span class="d-inline-block" tabindex="0" data-bs-toggle="popover">
														<label for="edit-summary" class="form-label fw-semibold">Summary</label>
														<i class="bi bi-info-circle fs-5 text-primary"></i>
														<ul class="list-group list-group-flush d-none">
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-x text-danger"></i> Pygmalion</span> &middot; <em>Not used</em>
															</li>
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-x text-danger"></i> Text Generation</span> &middot; <em>Not used</em>
															</li>
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-check text-success"></i> TavernAI</span> &middot; Personality summary
																<p class="mb-0">A brief description of the personality</p>
															</li>
															<li class="list-group-item d-none">
																<span class="fw-semibold"><i class="bi bi-x text-danger"></i> KoboldAI</span> &middot; <em>???</em>
															</li>
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-check text-success"></i> CharacterAI</span> &middot; Short Description
																<p class="mb-0">In just a few words, how would your Character describe themselves?</p>
															</li>
														</ul>
													</span>

													<textarea class="form-control auto-size" id="edit-summary" rows="1"></textarea>
													<label for="edit-summary" class="form-label float-end mt-1 small text-secondary"></label>
												</div>

												<div class="mb-3">
													<span class="d-inline-block " tabindex="0" data-bs-toggle="popover">
														<label for="edit-personality" class="form-label fw-semibold">Personality</label>
														<i class="bi bi-info-circle fs-5 text-primary"></i>
														<ul class="list-group list-group-flush d-none">
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-check text-success"></i> Pygmalion</span> &middot; Character Persona
																<p class="mb-0">Describe the character's persona here. Think of this as CharacterAI's description + definitions in one box.</p>
															</li>
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-check text-success"></i> Text Generation</span> &middot; Context (Persona)
															</li>
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-check text-success"></i> TavernAI</span> &middot; Description
																<p class="mb-0">Description of personality and other characteristics</p>
															</li>
															<li class="list-group-item d-none">
																<span class="fw-semibold"><i class="bi bi-x text-danger"></i> KoboldAI</span> &middot; <em>???</em>
															</li>
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-check text-success"></i> CharacterAI</span> &middot; Long Description
																<p class="mb-0">In a few sentences, how would your Character describe themselves?</p>
															</li>
														</ul>
													</span>

													<textarea class="form-control auto-size" id="edit-personality" rows="1"></textarea>
													<label for="edit-personality" class="form-label float-end mt-1 small text-secondary"></label>
												</div>

												<div class="mb-3">
													<span class="d-inline-block" tabindex="0" data-bs-toggle="popover">
														<label for="edit-scenario" class="form-label fw-semibold">Scenario</label>
														<i class="bi bi-info-circle fs-5 text-primary"></i>
														<ul class="list-group list-group-flush d-none">
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-check text-success"></i> Pygmalion</span> &middot; Scenario
																<p class="mb-0">Optionally, describe the starting scenario in a few short sentences.</p>
															</li>
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-check text-success"></i> Text Generation</span> &middot; Context (Scenario)
															</li>
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-check text-success"></i> TavernAI</span> &middot; Scenario
																<p class="mb-0">Circumstances and context of the dialogue</p>
															</li>
															<li class="list-group-item d-none">
																<span class="fw-semibold"><i class="bi bi-x text-danger"></i> KoboldAI</span> &middot; <em>???</em>
															</li>
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-x text-danger"></i> CharacterAI</span> &middot; <em>Not used</em>
															</li>
														</ul>
													</span>

													<textarea class="form-control auto-size" id="edit-scenario" rows="1"></textarea>
													<label for="edit-scenario" class="form-label float-end mt-1 small text-secondary"></label>
												</div>

												<div class="mb-3">
													<span class="d-inline-block" tabindex="0" data-bs-toggle="popover">
														<label for="edit-greeting" class="form-label fw-semibold">Greeting Message</label>
														<i class="bi bi-info-circle fs-5 text-primary"></i>
														<ul class="list-group list-group-flush d-none">
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-check text-success"></i> Pygmalion</span> &middot; Character Greeting
																<p class="mb-0">Write the character's greeting here. They will say this verbatim as their first response.</p>
															</li>
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-check text-success"></i> Text Generation</span> &middot; <em>Used but uneditable</em>
															</li>
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-check text-success"></i> TavernAI</span> &middot; First message
																<p class="mb-0">First message from the character</p>
															</li>
															<li class="list-group-item d-none">
																<span class="fw-semibold"><i class="bi bi-x text-danger"></i> KoboldAI</span> &middot; <em>???</em>
															</li>
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-check text-success"></i> CharacterAI</span> &middot; Greeting
																<p class="mb-0">What would your Character say to start a conversation?</p>
															</li>
														</ul>
													</span>

													<textarea class="form-control auto-size" id="edit-greeting" rows="1"></textarea>
													<label for="edit-greeting" class="form-label float-end mt-1 small text-secondary"></label>
												</div>

												<div class="mb-3">
													<span class="d-inline-block" tabindex="0" data-bs-toggle="popover">
														<label for="edit-examples" class="form-label fw-semibold">Example Messages</label>
														<i class="bi bi-info-circle fs-5 text-primary"></i>
														<ul class="list-group list-group-flush d-none">
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-check text-success"></i> Pygmalion</span> &middot; Example Chat
																<p class="mb-0">Optionally, write in an example chat here. This is useful for showing how the character should behave, for example.</p>
															</li>
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-check text-success"></i> Text Generation</span> &middot; <em>Used but uneditable</em>
															</li>
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-check text-success"></i> TavernAI</span> &middot; Examples of dialogue
																<p class="mb-0">Forms a personality more clearly</p>
															</li>
															<li class="list-group-item d-none">
																<span class="fw-semibold"><i class="bi bi-x text-danger"></i> KoboldAI</span> &middot; <em>???</em>
															</li>
															<li class="list-group-item">
																<span class="fw-semibold"><i class="bi bi-check text-success"></i> CharacterAI</span> &middot; Definition
																<p class="mb-0">Example conversations and information to define your Character</p>
															</li>
														</ul>
													</span>

													<textarea class="form-control auto-size" id="edit-examples" rows="1"></textarea>
													<label for="edit-examples" class="form-label float-end mt-1 small text-secondary"></label>
												</div>

												<div class="clearfix"></div>
												<span id="edit-tokens" class="float-end small text-secondary"></span>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="accordion-item">
						<h2 class="accordion-header">
							<button class="accordion-button collapsed shadow-none fs-5" type="button" data-bs-toggle="collapse" data-bs-target="#accordion-export" disabled autocomplete="off">
								<i class="bi bi-box-arrow-down flex-shrink-0 me-2"></i> Export
							</button>
						</h2>

						<div id="accordion-export" class="accordion-collapse collapse" data-bs-parent="#accordion">
							<div class="accordion-body text-center">
								<div class="container">
									<div class="row py-3 px-5">
										<div id="export-image" class="col-12 col-lg border-end-0 border-end-lg border-bottom border-bottom-lg-0 pb-4 pb-lg-0 mb-4 mb-lg-0 d-none">
											<h4>Export as Image</h4>
											<button id="export-png" type="button" class="btn btn-outline-primary my-3"><i class="bi bi-download flex-shrink-0 me-1"></i> Download as Character Card Image</button>
											<p>Compatible with <a href="https://github.com/oobabooga/text-generation-webui" target="_blank">Text Generation</a> / <a href="https://github.com/TavernAI/TavernAI" target="_blank">TavernAI</a></p>

											<div class="mt-4 small text-body-secondary">
												Character Cards are PNG images with embedded JSON
											</div>
										</div>

										<div class="col-12 col-lg">
											<h4>Export as JSON</h4>
											<button id="export-json" type="button" class="btn btn-outline-primary my-3"><i class="bi bi-download flex-shrink-0 me-1"></i> Download as Character JSON</button>
											<p>Compatible with <a href="https://github.com/PygmalionAI/gradio-ui" target="_blank">Pygmalion</a> / <a href="https://github.com/oobabooga/text-generation-webui" target="_blank">Text Generation</a> / <a href="https://github.com/TavernAI/TavernAI" target="_blank">TavernAI</a></p>

											<div class="mt-4 small text-body-secondary">
												Having problems with the Hybrid JSON?<br>
												<a href="" id="export-json-gradio" class="link-secondary">Download as Pygmalion / Text Generation JSON</a><br>
												<a href="" id="export-json-tavern" class="link-secondary">Download as TavernAI JSON</a>
											</div>

											<div class="mt-4 small text-danger">
												There is currently a bug in TavernAI which stops it from importing all data from JSON files! You are strongly encouraged to import your character as a Character Card image to avoid the issue
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>

	<footer class="footer mt-auto p-3 bg-body">
		<div class="container">
			<div class="row text-body-secondary user-select-none">
				<div class="col">
					<span data-bs-toggle="tooltip" data-bs-title="Get in contact on Discord for any suggestions or help!">Made with <code class="user-select-all"> Ayush Patel</code></span>
				</div>

				<div class="col text-end">
					Version 0.5
				</div>
			</div>
		</div>
	</footer>

	<div id="error-modal" class="modal fade" tabindex="-1" aria-labelledby="error-modal-heading" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h1 id="error-modal-heading" class="modal-title fs-5 text-danger"><i class="bi bi-exclamation-octagon"></i> An Error has Occurred</h1>
				</div>

				<div class="modal-body">
					<p>An unexpected error has occurred, sorry!</p>
					<p>This tool is still in development and you can help improve it by sending the error message below and your file (if applicable) to <code class="user-select-all">Zoltan#8287</code> on Discord or by reporting it on <a href="https://github.com/ZoltanAI/character-editor" target="_blank">GitHub</a>.</p>
					<pre class="mb-0 p-3 border bg-body-secondary rounded"><code id="error-message" class="user-select-all"></code></pre>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<div id="warning-modal" class="modal fade" tabindex="-1" aria-labelledby="warning-modal-heading" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h1 id="warning-modal-heading" class="modal-title fs-5 text-danger"><i class="bi bi-exclamation-octagon"></i> <span id="warning-modal-title"></span></h1>
				</div>

				<div class="modal-body">
					<p id="warning-modal-body" class="m-0"></p>

					<div id="warning-modal-collapse" class="collapse">
						<hr>
						<p>If you think you have mistakenly received this warning, please send the error message below and your file to <code class="user-select-all">Zoltan#8287</code> on Discord or report it on <a href="https://github.com/ZoltanAI/character-editor" target="_blank">GitHub</a>.</p>
						<pre class="mb-0 p-3 border bg-body-secondary rounded"><code id="warning-modal-details" class="user-select-all"></code></pre>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-outline-secondary me-auto" data-bs-toggle="collapse" data-bs-target="#warning-modal-collapse" aria-expanded="false" aria-controls="warning-modal-collapse">
						<i class="bi bi-chevron-expand"></i> Details
					</button>

					<button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/combine/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js,npm/crc-32@1.2,gh/syonfox/GPT-3-Encoder@c3c2e2533a15645d812b5e6fcb00b75b74718161/browser.min.js"></script>
	<script>
		'use strict';

		const APP = 'AI Character Editor';
		const VER = '0.5.0';

		Element.prototype.show = function () {
			this.classList.remove('d-none');
		};
		Element.prototype.hide = function () {
			this.classList.add('d-none');
		};

		const JsonFormats = {
			TextGenerationCharacter: 'Text Generation Character',
			TavernCharacter: 'TavernAI Character',
			KoboldCharacter: 'KoboldAI Character',
			CaiCharacter: 'CharacterAI Character',
			CaiHistory: 'CharacterAI History'
		};

		class JsonParseError extends Error {
			#json;

			get json() {
				return this.#json;
			}

			constructor(message, json, options) {
				super(message, options);

				this.name = 'JSON Parse Error';
				this.#json = json;
			}
		}

		class JsonUnknownFormatError extends Error {
			#json;

			get json() {
				return this.#json;
			}

			constructor(message, json, options) {
				super(message, options);

				this.name = 'Unknown JSON Format Error';
				this.#json = json;
			}
		}

		class PngDecodeError extends Error {
			constructor(message, options) {
				super(message, options);

				this.name = 'PNG Decode Error';
			}
		}

		class PngFormatError extends Error {
			constructor(message, options) {
				super(message, options);

				this.name = 'PNG Format Error';
			}
		}

		class PngMissingCharacterError extends Error {
			constructor(message, options) {
				super(message, options);

				this.name = 'PNG Missing Character Error';
			}
		}

		class PngInvalidCharacterError extends Error {
			constructor(message, options) {
				super(message, options);

				this.name = 'PNG Invalid Character Error';
			}
		}

		class Exception {
			static #modal = new bootstrap.Modal('#error-modal', {
				backdrop: 'static'
			});

			static set #message(value) {
				document.getElementById('error-message').innerText = value;
			}

			static format(ex, indent = 0) {
				let message = `${' '.repeat(indent)}${ex.name ?? 'Error'}: ${ex.message}`;

				if (ex.lineNumber) {
					message += ` (${ex.lineNumber}`;

					if (ex.columnNumber) message += `:${ex.columnNumber}`;

					message += ')';
				}

				message += '\n';

				if (ex.cause) message += this.format(ex.cause, indent + 2);

				if (ex instanceof JsonParseError && ex.json) message += `Source: "${ex.json}"\n`;
				if (ex instanceof JsonUnknownFormatError && ex.json) message += `Source: "${Format.stringify(ex.json)}"\n`;

				if (ex instanceof TypeError && ex.stack && indent == 0) message += `\n${ex.stack}`;

				return message;
			}

			static show(ex) {
				console.error(ex);

				this.#message = `${APP} v${VER}\n${this.format(ex)}`.trim();

				this.#modal.show();
			}
		}

		class Warning {
			static #modal = new bootstrap.Modal('#warning-modal', {
				backdrop: 'static'
			});

			static set #title(value) {
				document.getElementById('warning-modal-title').innerText = value;
			}

			static set #message(value) {
				document.getElementById('warning-modal-body').innerHTML = value;
			}

			static set #details(value) {
				document.getElementById('warning-modal-details').innerText = value;
			}

			static show(title, message, ex) {
				console.warn(ex);

				document.getElementById('warning-modal-collapse').classList.remove('show');

				this.#title = title;
				this.#message = message;
				this.#details = Exception.format(ex);

				this.#modal.show();
			}
		}

		class Format {
			static bytes(bytes, decimals = 2) {
				if (bytes == 1) return '0 bytes';
				if (bytes == 1) return '1 byte';

				const k = 1024;
				const i = Math.floor(Math.log(bytes) / Math.log(k));

				return parseFloat((bytes / Math.pow(k, i)).toFixed(decimals)) + ' ' + ['bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'][i];
			}

			static dateTime(date) {
				return new Intl.DateTimeFormat(undefined, {
					dateStyle: 'long',
					timeStyle: 'medium',
					hour12: true
				}).format(date);
			}

			static ago(date) {
				const DIVISIONS = [
					{ amount: 60, name: 'seconds' },
					{ amount: 60, name: 'minutes' },
					{ amount: 24, name: 'hours' },
					{ amount: 7, name: 'days' },
					{ amount: 4.34524, name: 'weeks' },
					{ amount: 12, name: 'months' },
					{ amount: Number.POSITIVE_INFINITY, name: 'years' }
				];

				let duration = (date - new Date()) / 1000;

				for (let i = 0; i <= DIVISIONS.length; i++) {
					const division = DIVISIONS[i];

					if (Math.abs(duration) < division.amount) {
						return Format.capitalize(new Intl.RelativeTimeFormat(undefined, {
							numeric: 'auto'
						}).format(Math.round(duration), division.name));
					}

					duration /= division.amount;
				}
			}

			static ratio(width, height) {
				return height == 0 ? width : Format.ratio(height, width % height);
			}

			static capitalize(text) {
				return text && text.charAt(0).toUpperCase() + text.slice(1);
			}

			static pluralize(count, singular, plural) {
				switch (new Intl.PluralRules('en').select(count)) {
					case 'one':
						return singular;
					default:
						return plural;
				}
			}

			static stringify(object) {
				return JSON.stringify(object, null, '\t');
			}
		}

		class Png {
			static #uint8 = new Uint8Array(4);
			static #int32 = new Int32Array(this.#uint8.buffer);
			static #uint32 = new Uint32Array(this.#uint8.buffer);

			// Parse and extract PNG tEXt chunk
			static #decodeText(data) {
				let naming = true;
				let keyword = '';
				let text = '';

				for (let index = 0; index < data.length; index++) {
					const code = data[index];

					if (naming) {
						if (code) {
							keyword += String.fromCharCode(code);
						} else {
							naming = false;
						}
					} else {
						if (code) {
							text += String.fromCharCode(code);
						} else {
							throw new PngDecodeError('Invalid NULL character found in PNG tEXt chunk');
						}
					}
				}

				return {
					keyword,
					text
				};
			}

			// Encode value to PNG tEXt chunk
			static #encodeText(keyword, text) {
				keyword = String(keyword);
				text = String(text);

				if (!/^[\x00-\xFF]+$/.test(keyword) || !/^[\x00-\xFF]+$/.test(text)) throw new PngDecodeError('Invalid character in PNG tEXt chunk');
				if (keyword.length > 79) throw new PngDecodeError('Keyword "' + keyword + '" is longer than the 79 character limit');

				const data = new Uint8Array(keyword.length + text.length + 1);
				let idx = 0;
				let code;

				for (let i = 0; i < keyword.length; i++) {
					if (!(code = keyword.charCodeAt(i))) throw new PngDecodeError('0x00 character is not permitted in tEXt keywords');
					data[idx++] = code;
				}

				data[idx++] = 0;

				for (let i = 0; i < text.length; i++) {
					if (!(code = text.charCodeAt(i))) throw new PngDecodeError('0x00 character is not permitted in tEXt text');
					data[idx++] = code;
				}

				return data;
			}

			// Read PNG format chunk
			static #readChunk(data, idx) {
				// Read length field
				this.#uint8[3] = data[idx++];
				this.#uint8[2] = data[idx++];
				this.#uint8[1] = data[idx++];
				this.#uint8[0] = data[idx++];
				const length = this.#uint32[0];

				// Read chunk type field
				const chunkType = String.fromCharCode(data[idx++]) + String.fromCharCode(data[idx++]) + String.fromCharCode(data[idx++]) + String.fromCharCode(data[idx++]);

				// Read chunk data field
				const chunkData = data.slice(idx, idx + length);
				idx += length;

				// Read CRC field
				this.#uint8[3] = data[idx++];
				this.#uint8[2] = data[idx++];
				this.#uint8[1] = data[idx++];
				this.#uint8[0] = data[idx++];
				const crc = this.#int32[0];

				// Compare stored CRC to actual
				if (crc !== CRC32.buf(chunkData, CRC32.str(chunkType))) throw new PngDecodeError('CRC for "' + chunkType + '" header is invalid, file is likely corrupted');

				return {
					type: chunkType,
					data: chunkData,
					crc
				};
			}

			// Read PNG file and extract chunks
			static #readChunks(data) {
				if (data[0] !== 0x89 || data[1] !== 0x50 || data[2] !== 0x4E || data[3] !== 0x47 || data[4] !== 0x0D || data[5] !== 0x0A || data[6] !== 0x1A || data[7] !== 0x0A) throw new PngFormatError('Invalid PNG header');

				const chunks = [];

				let idx = 8; // Skip signature
				while (idx < data.length) {
					const chunk = Png.#readChunk(data, idx);

					if (!chunks.length && chunk.type !== 'IHDR') throw new PngDecodeError('PNG missing IHDR header');

					chunks.push(chunk);
					idx += 4 + 4 + chunk.data.length + 4; // Skip length, chunk type, chunk data, CRC
				}

				if (chunks.length === 0) throw new PngDecodeError('PNG ended prematurely, no chunks');
				if (chunks[chunks.length - 1].type !== 'IEND') throw new PngDecodeError('PNG ended prematurely, missing IEND header');

				return chunks;
			}

			// Write PNG file from chunks
			static #encodeChunks(chunks) {
				const output = new Uint8Array(chunks.reduce((a, c) => a + 4 + 4 + c.data.length + 4, 8)); // Signature + chunks (length, chunk type, chunk data, CRC)

				// Signature
				output[0] = 0x89;
				output[1] = 0x50;
				output[2] = 0x4E;
				output[3] = 0x47;
				output[4] = 0x0D;
				output[5] = 0x0A;
				output[6] = 0x1A;
				output[7] = 0x0A;

				let idx = 8; // After signature

				chunks.forEach(c => {
					// Write length field
					this.#uint32[0] = c.data.length;
					output[idx++] = this.#uint8[3];
					output[idx++] = this.#uint8[2];
					output[idx++] = this.#uint8[1];
					output[idx++] = this.#uint8[0];

					// Write chunk type field
					output[idx++] = c.type.charCodeAt(0);
					output[idx++] = c.type.charCodeAt(1);
					output[idx++] = c.type.charCodeAt(2);
					output[idx++] = c.type.charCodeAt(3);

					// Write chunk data field
					for (let i = 0; i < c.data.length;) {
						output[idx++] = c.data[i++];
					}

					// Write CRC field
					this.#int32[0] = c.crc || CRC32.buf(c.data, CRC32.str(c.type));
					output[idx++] = this.#uint8[3];
					output[idx++] = this.#uint8[2];
					output[idx++] = this.#uint8[1];
					output[idx++] = this.#uint8[0];
				});

				return output;
			}

			// Parse PNG file and return decoded UTF8 "chara" base64 tEXt chunk value
			static Parse(arrayBuffer) {
				const chunks = Png.#readChunks(new Uint8Array(arrayBuffer));

				const text = chunks.filter(c => c.type === 'tEXt').map(c => Png.#decodeText(c.data));
				if (text.length < 1) throw new PngMissingCharacterError('No PNG text fields found in file');

				const chara = text.find(t => t.keyword === 'chara');
				if (chara === undefined) throw new PngMissingCharacterError('No PNG text field named "chara" found in file');

				try {
					return new TextDecoder().decode(Uint8Array.from(atob(chara.text), c => c.charCodeAt(0)));
				} catch (e) {
					throw new PngInvalidCharacterError('Unable to parse "chara" field as base64', {
						cause: e
					});
				}
			}

			// Parse PNG file, strip all tEXt chunks, add encoded UTF8 "chara" base64 tEXt chunk and return PNG file
			static Generate(arrayBuffer, text) {
				// Read PNG and remove all tEXt chunks, as TavernAI does
				// NOTE: TavernAI blindly reads first tEXt chunk, rather than searching for one named "chara"
				const chunks = Png.#readChunks(new Uint8Array(arrayBuffer)).filter(c => c.type !== 'tEXt');

				// Insert new "chara" tEXt chunk just before IEND chunk, as TavernAI does
				// NOTE: Some programs won't see the tEXt chunk if its after any IDAT chunks
				chunks.splice(-1, 0, {
					type: 'tEXt',
					data: Png.#encodeText('chara', btoa(new TextEncoder().encode(text).reduce((a, c) => a + String.fromCharCode(c), '')))
				});

				return Png.#encodeChunks(chunks);
			}
		}

		class Loader {
			// Create image element and wait for it to load
			static image(src) {
				return new Promise((resolve, reject) => {
					const image = new Image();
					image.onload = () => resolve(image);
					image.onerror = reject;
					image.crossOrigin = 'anonymous';
					image.src = src;
				});
			}

			// Parse JSON and wrap any error
			static #json(text) {
				try {
					return JSON.parse(text);
				} catch (ex) {
					throw new JsonParseError('Unable to parse', text, {
						cause: ex
					});
				}
			}

			static async parse(file) {
				let json = null;
				let image = null;

				if (file.type === 'application/json') {
					json = this.#json(await file.text());
				} else if (file.type === 'image/png') {
					const text = Png.Parse(await file.arrayBuffer());

					try {
						json = this.#json(text);
					} catch (ex) {
						if (!(ex instanceof JsonParseError)) throw ex;

						throw new PngInvalidCharacterError('Unable to parse "chara" field as JSON', {
							cause: ex
						});
					}

					image = await this.image(URL.createObjectURL(file));
				}

				return {
					json,
					image
				};
			}
		}

		class Popovers {
			constructor() {
				document.querySelectorAll('[data-bs-toggle="popover"]').forEach(el => new bootstrap.Popover(el, {
					trigger: 'hover',
					html: true,
					offset: [0, 15],
					content: () => {
						const ul = el.querySelector(':scope > ul').cloneNode(true);
						ul.show();
						return ul.outerHTML;
					}
				}));
			}
		}

		class Tooltips {
			static #imageDetails;
			static #fileDate;
			static #footer;

			static get imageDetails() {
				return this.#imageDetails;
			}

			static get fileDate() {
				return this.#fileDate;
			}

			static get footer() {
				return this.#footer;
			}

			static #create(el) {
				return new bootstrap.Tooltip(el, {
					html: true
				});
			}

			constructor() {
				const elements = document.querySelectorAll('[data-bs-toggle="tooltip"]');

				// TODO: Only get required tooltips
				Tooltips.#imageDetails = Tooltips.#create(elements[0]);
				Tooltips.#fileDate = Tooltips.#create(elements[1]);
				Tooltips.#footer = Tooltips.#create(elements[2]);
			}
		}

		class Accordions {
			static #load;
			static #edit;
			static #export;

			#opening = false;

			static get load() {
				return this.#load;
			}

			static get edit() {
				return this.#edit;
			}

			static get export() {
				return this.#export;
			}

			static #create(el) {
				return new bootstrap.Collapse(el, {
					toggle: false
				});
			}

			static lock(lock = true) {
				document.querySelectorAll('.accordion-header button').forEach(el => {
					el.disabled = lock;
				});
			}

			constructor() {
				const elements = document.querySelectorAll('.accordion-collapse');

				Accordions.#load = Accordions.#create(elements[0]);
				Accordions.#edit = Accordions.#create(elements[1]);
				Accordions.#export = Accordions.#create(elements[2]);

				elements.forEach(el => {
					el.addEventListener('hide.bs.collapse', e => {
						if (!this.#opening) {
							e.preventDefault();
							e.stopPropagation();
						} else {
							this.#opening = false;
						}
					});

					el.addEventListener('show.bs.collapse', e => {
						this.#opening = true;
					});
				});
			}
		}

		class Tokenizer {
			static count(str) {
				return gpt3encoder.countTokens(str || '');
			}

			static update(el) {
				if (el === undefined) {
					document.querySelectorAll('input[type=text], textarea').forEach(el => {
						this.update(el);

						const total = gpt3encoder.countTokens(Edit.name + Edit.summary + Edit.personality + Edit.scenario + Edit.greeting + Edit.examples);
						document.getElementById('edit-tokens').innerText = `${total.toLocaleString()} total ${Format.pluralize(total, 'token', 'tokens')}`;
					});

					return;
				}

				const str = el.value.trim();
				const tokens = gpt3encoder.countTokens(str);

				// TODO: Improve
				let nextSibling = el.nextSibling;
				while (nextSibling && nextSibling.nodeType != 1) {
					nextSibling = nextSibling.nextSibling;
				}

				nextSibling.innerText = `${str.length.toLocaleString()} ${Format.pluralize(str.length, 'character', 'characters')}, ${tokens.toLocaleString()} ${Format.pluralize(tokens, 'token', 'tokens')}`;

				const total = gpt3encoder.countTokens(Edit.name + Edit.summary + Edit.personality + Edit.scenario + Edit.greeting + Edit.examples);
				document.getElementById('edit-tokens').innerText = `${total.toLocaleString()} total ${Format.pluralize(total, 'token', 'tokens')}`;
			}

			constructor() {
				document.querySelectorAll('input[type=text], textarea').forEach(el => {
					Tokenizer.update(el);

					el.addEventListener('input', e => {
						Tokenizer.update(e.target);
					});
				});
			}
		}

		class TextareaAutoSize {
			static update(el) {
				if (el === undefined) {
					document.querySelectorAll('.auto-size').forEach(el => {
						this.update(el);
					});

					return;
				}

				const style = getComputedStyle(el, null);

				el.style.height = parseInt(style['fontSize']) + 'px';
				el.style.height = (parseInt(el.scrollHeight) + (parseInt(style['borderTopWidth']) + parseInt(style['borderBottomWidth']) || 0)) + 'px';
			}

			constructor() {
				document.querySelectorAll('.auto-size').forEach(el => {
					TextareaAutoSize.update(el);

					el.addEventListener('input', e => {
						TextareaAutoSize.update(e.target);
					});
				});
			}
		}

		class CaiMetadata {
			#id;
			#avatar;
			#categories = [];
			#visibility;
			#interactions;
			#imageGeneration;

			get id() {
				return this.#id;
			}

			get avatar() {
				return this.#avatar;
			}

			get categories() {
				return this.#categories;
			}

			get visibility() {
				return this.#visibility;
			}

			get interactions() {
				return this.#interactions;
			}

			get imageGeneration() {
				return this.#imageGeneration;
			}

			#valid(object, key) {
				if (!object || !object.hasOwnProperty(key)) return false;

				const value = object[key];

				if (object[key] === undefined || object[key] === null) return false;
				if (Array.isArray(object[key]) && object[key].length < 1) return false;
				if ((typeof object[key] === 'string' || object[key] instanceof String) && (!object[key] || !object[key].trim())) return false;

				return true;
			}

			#sanitize(object, key) {
				if (!this.#valid(object, key)) return null;

				if (typeof object[key] === 'string' || object[key] instanceof String) return object[key].trim();

				return object[key];
			}

			constructor(json) {
				if (!json) return;

				if (this.#valid(json, 'external_id')) this.#id = this.#sanitize(json, 'external_id');
				if (this.#valid(json, 'avatar_file_name')) this.#avatar = this.#sanitize(json, 'avatar_file_name');
				if (this.#valid(json, 'categories')) this.#categories = this.#sanitize(json, 'categories').map(c => c.name);
				if (this.#valid(json, 'visibility')) this.#visibility = this.#sanitize(json, 'visibility');
				if (this.#valid(json, 'num_interactions')) this.#interactions = this.#sanitize(json, 'num_interactions'); // CIA Character
				if (this.#valid(json, 'participant__num_interactions')) this.#interactions = this.#sanitize(json, 'participant__num_interactions'); // CIA History
				if (this.#valid(json, 'img_gen_enabled')) this.#imageGeneration = this.#sanitize(json, 'img_gen_enabled');
			}
		}

		class Character {
			#name;
			#summary;
			#personality;
			#scenario;
			#greeting;
			#examples;

			get name() {
				return this.#name;
			}

			get summary() {
				return this.#summary;
			}

			get personality() {
				return this.#personality;
			}

			get scenario() {
				return this.#scenario;
			}

			get greeting() {
				return this.#greeting;
			}

			get examples() {
				return this.#examples;
			}

			get tokens() {
				return Tokenizer.count(this.name + this.summary + this.personality + this.scenario + this.greeting + this.examples);
			}

			#valid(object, key) {
				if (!object || !object.hasOwnProperty(key) || !object[key] || !object[key].trim()) return false;

				return true;
			}

			#sanitize(object, key) {
				return this.#valid(object, key) ? object[key].trim() : null;
			}

			constructor(json) {
				if (!json) return;

				console.log(json);

				// Text Generation
				if (this.#valid(json, 'char_name')) this.#name = this.#sanitize(json, 'char_name');
				if (this.#valid(json, 'char_persona')) this.#personality = this.#sanitize(json, 'char_persona');
				if (this.#valid(json, 'world_scenario')) this.#scenario = this.#sanitize(json, 'world_scenario');
				if (this.#valid(json, 'char_greeting')) this.#greeting = this.#sanitize(json, 'char_greeting');
				if (this.#valid(json, 'example_dialogue')) this.#examples = this.#sanitize(json, 'example_dialogue');

				// TavernAI
				if (this.#valid(json, 'name')) this.#name = this.#sanitize(json, 'name');
				if (this.#valid(json, 'personality')) this.#summary = this.#sanitize(json, 'personality');
				if (this.#valid(json, 'description')) this.#personality = this.#sanitize(json, 'description');
				if (this.#valid(json, 'scenario')) this.#scenario = this.#sanitize(json, 'scenario');
				if (this.#valid(json, 'first_mes')) this.#greeting = this.#sanitize(json, 'first_mes');
				if (this.#valid(json, 'mes_example')) this.#examples = this.#sanitize(json, 'mes_example');

				// CIA Character
				if (json.character) {
					if (this.#valid(json.character, 'name')) this.#name = this.#sanitize(json.character, 'name');
					if (this.#valid(json.character, 'title')) this.#summary = this.#sanitize(json.character, 'title');
					if (this.#valid(json.character, 'description')) this.#personality = this.#sanitize(json.character, 'description');
					if (this.#valid(json.character, 'greeting')) this.#greeting = this.#sanitize(json.character, 'greeting');
					if (this.#valid(json.character, 'definition')) this.#examples = this.#sanitize(json.character, 'definition');
				}

				// CIA History
				if (json.info && json.info.character) {
					if (this.#valid(json.info.character, 'name')) this.#name = this.#sanitize(json.info.character, 'name');
					if (this.#valid(json.info.character, 'title')) this.#summary = this.#sanitize(json.info.character, 'title');
					if (this.#valid(json.info.character, 'description')) this.#personality = this.#sanitize(json.info.character, 'description');
					if (this.#valid(json.info.character, 'greeting')) this.#greeting = this.#sanitize(json.info.character, 'greeting');
					if (this.#valid(json.info.character, 'definition')) this.#examples = this.#sanitize(json.info.character, 'definition');
				}
			}
		}

		class Source {
			#file;
			#json;
			#image;
			#character;
			#formats = [];
			#metadata = {};

			get file() {
				return this.#file;
			}

			get json() {
				return this.#json;
			}

			get image() {
				return this.#image;
			}

			get character() {
				return this.#character;
			}

			get formats() {
				return this.#formats;
			}

			get metadata() {
				return this.#metadata;
			}

			#detectFormats(json) {
				const checkProperties = (properties, obj = json) => properties.every(p => obj.hasOwnProperty(p));

				if (checkProperties(['char_name', 'char_persona', 'world_scenario', 'char_greeting', 'example_dialogue'])) this.formats.push(JsonFormats.TextGenerationCharacter);
				if (checkProperties(['name', 'description', 'personality', 'scenario', 'first_mes', 'mes_example'])) this.formats.push(JsonFormats.TavernCharacter);
				if (json.character && checkProperties(['name', 'title', 'description', 'greeting', 'definition'], json.character)) this.formats.push(JsonFormats.CaiCharacter);
				if (json.info && json.info.character && checkProperties(['name', 'title', 'description', 'greeting'], json.info.character)) this.formats.push(JsonFormats.CaiHistory);
			}

			static async fromFile(file) {
				const { json, image } = await Loader.parse(file);

				return new Source(file, json, image);
			}

			constructor(file = null, json = null, image = null) {
				if (file) this.#file = file;
				if (json) this.#json = json;
				if (image) this.#image = image;

				this.#character = new Character(this.json);

				if (this.json) {
					this.#detectFormats(this.json);

					if (this.formats.length < 1) throw new JsonUnknownFormatError('Format not recognised', this.json);

					if (this.image) this.#formats = ['Character Card'];

					if (this.formats.includes(JsonFormats.CaiCharacter)) this.#metadata.cai = new CaiMetadata(this.json.character);
					if (this.formats.includes(JsonFormats.CaiHistory)) this.#metadata.cai = new CaiMetadata(this.json.info.character);
				}
			}
		}

		class Load extends EventTarget {
			#accordionElement = document.getElementById('accordion-load');
			#loadButtonElement = document.getElementById('load');
			#createButtonElement = document.getElementById('create');

			#dragStart() {
				this.#accordionElement.classList.add('bg-drag');
			}

			#dragStop() {
				this.#accordionElement.classList.remove('bg-drag');
			}

			#create() {
				this.dispatchEvent(new CustomEvent('create'));
			}

			#load(file) {
				this.dispatchEvent(new CustomEvent('load', {
					detail: {
						file
					}
				}));
			}

			constructor() {
				super();

				// New character button
				this.#createButtonElement.addEventListener('click', () => {
					this.#create();
				});

				// Load drag
				this.#accordionElement.addEventListener('dragover', e => {
					e.preventDefault();

					if (e.dataTransfer.items[0].kind === 'file' && (e.dataTransfer.items[0].type === 'application/json' || e.dataTransfer.items[0].type === 'image/png')) {
						e.dataTransfer.effectAllowed = 'move';
						e.dataTransfer.dropEffect = 'move';

						this.#dragStart();
					} else {
						e.dataTransfer.effectAllowed = 'none';
						e.dataTransfer.dropEffect = 'none';

						this.#dragStop();
					}
				});

				this.#accordionElement.addEventListener('dragleave', e => {
					e.preventDefault();

					this.#dragStop();
				});

				// Load drop
				this.#accordionElement.addEventListener('drop', e => {
					e.preventDefault();

					this.#dragStop();

					if (!e.dataTransfer.files || e.dataTransfer.files.length < 1) return;

					this.#load(e.dataTransfer.files[0]);
				});

				// Load button
				this.#loadButtonElement.addEventListener('change', e => {
					if (!e.target.files || e.target.files.length < 1) return;

					this.#load(e.target.files[0]);
				});
			}
		}

		// TODO: Remove static
		class Edit {
			static #caiWarningElement = document.getElementById('edit-alert-characterai-history');
			static #caiWarningLinkElement = document.getElementById('edit-alert-characterai-history-link');

			static #imageElement = document.getElementById('edit-image');
			static #imagePlaceholderElement = document.getElementById('edit-image-placeholder');
			static #imageDetailsElement = document.getElementById('edit-image-details');

			static #nameElement = document.getElementById('edit-name');
			static #summaryElement = document.getElementById('edit-summary');
			static #personalityElement = document.getElementById('edit-personality');
			static #scenarioElement = document.getElementById('edit-scenario');
			static #greetingElement = document.getElementById('edit-greeting');
			static #examplesElement = document.getElementById('edit-examples');

			static #originalContainerElement = document.getElementById('edit-original');
			static #originalNameElement = document.getElementById('edit-original-name');
			static #originalFormatElement = document.getElementById('edit-original-format');
			static #originalTokensElement = document.getElementById('edit-original-tokens');
			static #originalSizeElement = document.getElementById('edit-original-size');
			static #originalModifiedElement = document.getElementById('edit-original-modified');

			static #caiContainerElement = document.getElementById('edit-metadata-cai');
			static #caiLinkElement = document.getElementById('edit-metadata-cai-link');
			static #caiVisibilityElement = document.getElementById('edit-metadata-cai-visibility');
			static #caiInteractionsElement = document.getElementById('edit-metadata-cai-interactions');
			static #caiCategoriesElement = document.getElementById('edit-metadata-cai-categories');
			static #caiImageGenerationElement = document.getElementById('edit-metadata-cai-image-generation');

			static get name() {
				return this.#nameElement.value.trim();
			}

			static get summary() {
				return this.#summaryElement.value.trim();
			}

			static get personality() {
				return this.#personalityElement.value.trim();
			}

			static get scenario() {
				return this.#scenarioElement.value.trim();
			}

			static get greeting() {
				return this.#greetingElement.value.trim();
			}

			static get examples() {
				return this.#examplesElement.value.trim();
			}

			static #reset() {
				Edit.#caiWarningElement.hide();

				Edit.#imageElement.hide();
				Edit.#imageElement.removeAttribute('src');
				Edit.#imageElement.removeAttribute('alt');

				Edit.#imageDetailsElement.hide();
				Edit.#imageDetailsElement.innerText = null;

				Edit.#imagePlaceholderElement.show();

				Edit.#originalContainerElement.hide();

				Edit.#caiLinkElement.closest('.row').hide();
				Edit.#caiVisibilityElement.closest('.row').hide();
				Edit.#caiInteractionsElement.closest('.row').hide();
				Edit.#caiCategoriesElement.closest('.row').hide();
				Edit.#caiImageGenerationElement.closest('.row').hide();
				Edit.#caiContainerElement.hide();

				// TODO: Move
				document.getElementById('export-image').hide();
			}

			static #convertImage(image) {
				const canvas = document.createElement('canvas');
				canvas.width = image.width;
				canvas.height = image.height;

				const ctx = canvas.getContext('2d');
				ctx.drawImage(image, 0, 0);

				image.src = canvas.toDataURL('image/png');

				return image;
			}

			static #showImage(image, alt = null) {
				Edit.#imagePlaceholderElement.hide();

				Edit.#imageElement.src = image.src;
				if (alt) Edit.#imageElement.alt = alt;
				Edit.#imageElement.show();

				const ar = Format.ratio(image.width, image.height);
				Edit.#imageDetailsElement.innerText = `${image.width} x ${image.height}px (${image.width / ar}:${image.height / ar})`;
				Edit.#imageDetailsElement.show();

				// TODO: Move
				document.getElementById('export-image').show(); // Show export image option
			}

			load(source) {
				Edit.#reset();

				if (source.formats.length === 1 && source.formats.includes(JsonFormats.CaiHistory)) {
					Edit.#caiWarningLinkElement.href = `https://beta.character.ai/editing?char=${source.metadata.cai.id}`;
					Edit.#caiWarningElement.show();
				}

				if (source.image) Edit.#showImage(source.image, source.file.name);

				if (source.file) {
					Edit.#originalNameElement.innerText = source.file.name;

					Edit.#originalFormatElement.innerHTML = source.formats.join('<br>');

					Edit.#originalTokensElement.innerText = `${source.character.tokens.toLocaleString()} total`;

					Edit.#originalSizeElement.innerText = Format.bytes(source.file.size);

					Edit.#originalModifiedElement.innerText = Format.ago(source.file.lastModified);
					Edit.#originalModifiedElement.setAttribute('datetime', new Date(source.file.lastModified).toISOString());
					Tooltips.fileDate.setContent({
						'.tooltip-inner': Format.dateTime(source.file.lastModified)
					});

					Edit.#originalContainerElement.show();
				}

				if (source.metadata.cai) {
					const cai = source.metadata.cai;

					if (cai.avatar && !source.image) {
						Loader.image(`https://characterai.io/i/400/static/avatars/${cai.avatar}`).then(i => {
							Edit.#showImage(Edit.#convertImage(i), `${source.character.name} avatar`);
						});
					}

					if (cai.id) {
						Edit.#caiLinkElement.innerText = source.character.name;
						Edit.#caiLinkElement.href = `https://beta.character.ai/chat?char=${cai.id}`;
						Edit.#caiLinkElement.closest('.row').show();
					}

					if (cai.visibility) {
						Edit.#caiVisibilityElement.innerText = Format.capitalize(cai.visibility.toLowerCase());
						Edit.#caiVisibilityElement.closest('.row').show();
					}

					if (cai.interactions) {
						Edit.#caiInteractionsElement.innerText = cai.interactions.toLocaleString();
						Edit.#caiInteractionsElement.closest('.row').show();
					}

					if (cai.categories.length > 0) {
						Edit.#caiCategoriesElement.innerHTML = cai.categories.join('<br>');
						Edit.#caiCategoriesElement.closest('.row').show();
					}

					if (cai.imageGeneration !== undefined) {
						Edit.#caiImageGenerationElement.innerHTML = cai.imageGeneration ? 'Enabled' : 'Disabled';
						Edit.#caiImageGenerationElement.closest('.row').show();
					}

					Edit.#caiContainerElement.show();
				}

				Edit.#nameElement.value = source.character.name || '';
				Edit.#summaryElement.value = source.character.summary || '';
				Edit.#personalityElement.value = source.character.personality || '';
				Edit.#scenarioElement.value = source.character.scenario || '';
				Edit.#greetingElement.value = source.character.greeting || '';
				Edit.#examplesElement.value = source.character.examples || '';

				Accordions.lock(false);
				Accordions.edit.show();

				Tokenizer.update();
				TextareaAutoSize.update();

				Edit.#nameElement.focus();
			}

			// TODO: Cleanup
			constructor(source) {
				document.getElementById('edit-image-add').addEventListener('dragover', e => {
					e.preventDefault();

					if (e.dataTransfer.items[0].kind === 'file' && e.dataTransfer.items[0].type.startsWith('image/')) {
						e.dataTransfer.effectAllowed = 'move';
						e.dataTransfer.dropEffect = 'move';

						document.getElementById('edit-image-add').classList.add('hover');
					} else {
						e.dataTransfer.effectAllowed = 'none';
						e.dataTransfer.dropEffect = 'none';

						document.getElementById('edit-image-add').classList.remove('hover');
					}
				});

				document.getElementById('edit-image-add').addEventListener('dragleave', e => {
					e.preventDefault();

					document.getElementById('edit-image-add').classList.remove('hover');
				});

				document.getElementById('edit-image-add').addEventListener('drop', async e => {
					e.preventDefault();

					document.getElementById('edit-image-add').classList.remove('hover');

					if (!e.dataTransfer.files || e.dataTransfer.files.length < 1) return;

					const image = await Loader.image(URL.createObjectURL(e.dataTransfer.files[0]));

					Edit.#showImage(Edit.#convertImage(image), e.dataTransfer.files[0].name);
				});

				document.getElementById('edit-image-add').addEventListener('click', e => {
					e.preventDefault();

					document.getElementById('image').click();
				});

				document.getElementById('image').addEventListener('change', async e => {
					if (!e.target.files || e.target.files.length < 1) return;

					const image = await Loader.image(URL.createObjectURL(e.target.files[0]));

					Edit.#showImage(Edit.#convertImage(image), e.target.files[0].name);
				});
			}
		}

		class Exporter {
			// TODO: Populate
			static #metadata = {
				metadata: {
					version: 1,
					created: Date.now(),
					modified: Date.now(),
					source: null,
					tool: {
						name: APP,
						version: VER,
						url: 'https://ayush.github.io/character-editor/'
					}
				}
			};

			static #downloadFile(file) {
				const link = window.URL.createObjectURL(file);

				const a = document.createElement('a');
				a.setAttribute('download', file.name);
				a.setAttribute('href', link);
				a.click();
			}

			static Gradio() {
				return {
					char_name: document.getElementById('edit-name').value.trim() || '',
					char_persona: document.getElementById('edit-personality').value.trim() || '',
					world_scenario: document.getElementById('edit-scenario').value.trim() || '',
					char_greeting: document.getElementById('edit-greeting').value.trim() || '',
					example_dialogue: document.getElementById('edit-examples').value.trim() || ''
				};
			}

			static Tavern() {
				return {
					name: document.getElementById('edit-name').value.trim() || '',
					description: document.getElementById('edit-personality').value.trim() || '',
					personality: document.getElementById('edit-summary').value.trim() || '',
					scenario: document.getElementById('edit-scenario').value.trim() || '',
					first_mes: document.getElementById('edit-greeting').value.trim() || '',
					mes_example: document.getElementById('edit-examples').value.trim() || ''
				};
			}

			// TODO: Filename
			static Json(data) {
				const object = {
					...data,
					...Exporter.#metadata
				};

				const file = new File([JSON.stringify(object, undefined, '\t')], (data.char_name || data.name || 'character') + '.json', { type: 'application/json;charset=utf-8' });

				Exporter.#downloadFile(file);
			}

			static async Png(data) {
				const object = {
					...data,
					...Exporter.#metadata
				};

				const json = JSON.stringify(object, undefined, '\t');

				const request = await fetch(document.getElementById('edit-image').src);
				const blob = await request.blob();

				const png = Png.Generate(await blob.arrayBuffer(), json);

				const file = new File([png], (data.char_name || data.name || 'character') + '.card.png', { type: 'image/png' });

				Exporter.#downloadFile(file);
			}
		}

		class Export {
			constructor() {
				document.getElementById('export-json').addEventListener('click', () => {
					try {
						Exporter.Json({
							...Exporter.Gradio(),
							...Exporter.Tavern()
						});
					} catch (ex) {
						Exception.show(ex);
					}
				});

				document.getElementById('export-json-gradio').addEventListener('click', e => {
					e.preventDefault();

					try {
						Exporter.Json(Exporter.Gradio());
					} catch (ex) {
						Exception.show(ex);
					}
				});

				document.getElementById('export-json-tavern').addEventListener('click', e => {
					e.preventDefault();

					try {
						Exporter.Json(Exporter.Tavern());
					} catch (ex) {
						Exception.show(ex);
					}
				});

				document.getElementById('export-png').addEventListener('click', async () => {
					try {
						await Exporter.Png(Exporter.Tavern());
					} catch (ex) {
						Exception.show(ex);
					}
				});
			}
		}

		// Entrypoint
		(async () => {
			// Initialize visual elements
			new Popovers();
			new Tooltips();
			new Accordions();
			new Tokenizer();
			new TextareaAutoSize();

			// Disable form submission
			document.querySelectorAll('form').forEach(el => {
				el.addEventListener('submit', e => {
					e.preventDefault();
					e.stopPropagation();
				});
			});

			const load = new Load();
			const edit = new Edit();
			new Export();

			// New character
			load.addEventListener('create', () => {
				edit.load(new Source());
			});

			// Load character
			load.addEventListener('load', async e => {
				try {
					edit.load(await Source.fromFile(e.detail.file));
				} catch (ex) {
					if (ex instanceof JsonParseError) {
						Warning.show('Invalid JSON File', 'The file you have selected is not valid JSON format, please check the file and try again.', ex);
					} else if (ex instanceof PngFormatError) {
						Warning.show('Invalid PNG File', 'The file you have selected is not a valid PNG file, please make sure the file is actually in PNG format and try again.', ex);
					} else if (ex instanceof PngDecodeError) {
						Warning.show('Corrupt PNG File', 'The PNG file you have selected is corrupt, please make sure the file is a valid PNG and try again.', ex);
					} else if (ex instanceof PngInvalidCharacterError) {
						Warning.show('Corrupt Character Card Image', 'The PNG file you have selected contains corrupt character data.<br>Try re-downloading the original Character Card file if possible and make sure you do not manually edit the file.', ex);
					} else if (ex instanceof PngMissingCharacterError) {
						Warning.show('Invalid Character Card Image', 'The file you have selected is a plain PNG file and does not contain any character data.<br>Try re-downloading the original Character Card file if possible and make sure you do not manually edit the file.', ex);
					} else if (ex instanceof JsonUnknownFormatError) {
						Warning.show('Unknown JSON Format', 'The file you have selected is in a JSON format not supported by this editor.<br>If you think that your file is a valid character definition, please click the "Details" button and get in touch so support for it can be added.', ex);
					} else {
						Exception.show(ex);
					}
				}
			});
		})();
	</script>
</body>
</html>
